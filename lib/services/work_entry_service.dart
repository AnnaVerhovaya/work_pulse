import 'package:flutter_application_workpulse/database/work_entry_db.dart';
import 'package:flutter_application_workpulse/packages/src/model/models.dart';

class WorkEntryService {
  final WorEntryDataBase workEntryDB;

  WorkEntryService(this.workEntryDB);

  Future<WorkEntry?> getWorkEntry(DateTime date) async {
    return await workEntryDB.getWorkEntryByDate(date);
  }

  Future insertWorkEntry(WorkEntry workEntry) async {
    await workEntryDB.insertWorkEntry(workEntry);
  }

  Future updateWorkEntry(WorkEntry workEntry) async {
    await workEntryDB.updateWorkEntry(workEntry);
  }

  Future deleteWorkEntry(int id) async {
    await workEntryDB.deleteWorkEntry(id);
  }

  Future<List<WorkEntry>?> getWorkEntriesForMonth(int year, int month) async {
    return await workEntryDB.getWorkEntriesForMonth(year, month);
  }

  Future<double> getTotalIncomeForMonth(int year, int month) async {
    return await workEntryDB.getTotalIncomeForMonth(year, month);
  }

  Future<double> getTotalHoursForMonth(int year, int month) async {
    return await workEntryDB.getTotalHoursForMonth(year, month);
  }
}
