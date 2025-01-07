import 'dart:async';
import 'dart:developer';
import 'package:flutter_application_workpulse/packages/src/model/models.dart';
import 'package:flutter_application_workpulse/repositories/work_entry_db_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class WorEntryDataBase implements WorkEntryDBRepository {
  String get tableName => 'work_entry_db';
  static int get _version => 1;
  Database? _db;

  WorEntryDataBase();

  Future<Database> get database async {
    if (_db == null) {
      await _initDatabase();
    }
    return _db!;
  }

  Future<void> _initDatabase() async {
    try {
      String path = join(await getDatabasesPath(), '$tableName.db');
      _db = await openDatabase(
        path,
        version: _version,
        onCreate: (db, version) async {
          await db.execute(
            '''CREATE TABLE IF NOT EXISTS $tableName (
                  id INTEGER,
                  date INTEGER,  
                  hoursWorked REAL,
                  hourRate REAL,
                  totalIncome REAL,
                  isWorkDay INTEGER,
                  created_at INTEGER NOT NULL DEFAULT (strftime('%s', 'now'))
              );''',
          );
        },
      );
    } catch (exception) {
      log(exception.toString(), name: tableName);
    }
  }

  Future<void> recreateTable() async {
    Database db = await database;
    await db.rawQuery('DROP TABLE IF EXISTS $tableName;');
    _db = null;
    await _initDatabase();
  }

  Future<void> printDatabase() async {
    final res = await (await database).rawQuery('SELECT * FROM $tableName;');
    for (final row in res) {
      print('-----------------------------------------------');
      for (final column in row.keys) {
        print('$column: ${row[column]}');
      }
    }
  }

  @override
  Future<void> clearTable() async {
    Database db = await database;
    await db.rawQuery('DELETE FROM $tableName;');
  }

  @override
  Future<void> insertWorkEntry(WorkEntry workEntry) async {
    Database db = await database;
    try {
      log('Inserting work entry: ${workEntry.toString()}');
      await db.rawInsert(
        '''
      INSERT INTO $tableName (
        id,
        date,
        hoursWorked,
        hourRate,
        totalIncome,
        isWorkDay 
      )
      VALUES(
        ?, ?, ?, ?, ?, ?
      );
      ''',
        [
          workEntry.id,
          workEntry.date.millisecondsSinceEpoch,
          workEntry.hoursWorked,
          workEntry.hourRate,
          workEntry.totalIncome,
          workEntry.isWorkingDay ? 1 : 0,
        ],
      );
      log('Inserted into: $tableName, date: ${workEntry.date}');
    } catch (e) {
      log('Error inserting into $tableName: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteWorkEntry(int id) async {
    Database db = await database;
    await db.rawQuery('DELETE FROM $tableName WHERE id = ?;', [id]);
    log('Deleted entry from: $tableName, id: $id');
  }

  @override
  Future<WorkEntry?> getWorkEntryByDate(DateTime date) async {
    printDatabase();
    // Убедитесь, что база данных инициализирована

    final startDate = DateTime(date.year, date.month, date.day);
    final endDate = DateTime(date.year, date.month, date.day + 1);
    Database db = await database;
    if (db == null) {
      await _initDatabase(); 
    }
    try {
      final List<Map<String, dynamic>> results = await db!.rawQuery(
        '''
      SELECT 
        id,
        date,             
        hoursWorked,      
        hourRate,         
        totalIncome, 
        isWorkDay       
      FROM $tableName
      WHERE
        date >= ? AND date < ?;
      ''',
        [
          startDate.millisecondsSinceEpoch,
          endDate.millisecondsSinceEpoch,
        ],
      );
      if (results.isNotEmpty) {
        print('Data to load: ${results[0]}');
        return WorkEntry.load(results[0]);
      } else {
        return null; 
      }
    } catch (e) {
      print('Error while fetching work entry: ${e.toString()}');
      return null;
    }
  }

  @override
  Future<void> updateWorkEntry(WorkEntry workEntry) async {
    Database db = await database;
    await db.update(
      tableName,
      {
        'date': workEntry.date.millisecondsSinceEpoch,
        'hoursWorked': workEntry.hoursWorked,
        'hourRate': workEntry.hourRate,
        'totalIncome': workEntry.totalIncome,
      },
      where: 'date = ?',
      whereArgs: [workEntry.date],
    );
    log('Updated entry in: $tableName, date: ${workEntry.date}');
  }

  @override
  Future<List<WorkEntry>> getWorkEntriesForMonth(DateTime month) async {
    final startDate = DateTime(month.year, month.month, 1);
    final endDate = DateTime(month.year, month.month + 1, 1);

    final List<Map<String, dynamic>> results = await (await database).rawQuery(
      '''
        SELECT 
          id,               
          date,             
          hoursWorked,      
          hourRate,         
          totalIncome       
        FROM $tableName
        WHERE
          date >= ? AND date < ?;
      ''',
      [
        startDate.millisecondsSinceEpoch,
        endDate.millisecondsSinceEpoch,
      ],
    );

    return results.map((json) => WorkEntry.load(json)).toList();
  }

  @override
  Future<double> getTotalIncomeForMonth(DateTime month) async {
    final entries = await getWorkEntriesForMonth(month);
    double totalIncome = 0.0;

    for (var entry in entries) {
      totalIncome += entry.totalIncome;
    }

    return totalIncome;
  }

  @override
  Future<double> getTotalHoursForMonth(DateTime month) async {
    final entries = await getWorkEntriesForMonth(month);
    double totalHours = 0.0;

    for (var entry in entries) {
      totalHours += entry.hoursWorked;
    }

    return totalHours;
  }
}
