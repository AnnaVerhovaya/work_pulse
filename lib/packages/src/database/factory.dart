import 'dart:async';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

const int latestDatabaseVersion = 3;

Future<Database> open(String dbName,
    {int version = latestDatabaseVersion, bool nativeFactory = false}) async {
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
  }
  var factory = nativeFactory ? databaseFactory : databaseFactoryFfi;
  late final String path;
  if (dbName == inMemoryDatabasePath) {
    path = dbName;
  } else {
    var databaseDirectory = await getDatabasesPath();
    path = join(databaseDirectory, dbName);
  }
  return await factory.openDatabase(
    path,
    options: OpenDatabaseOptions(
        version: version,
        onConfigure: configure,
        onDowngrade: onDatabaseDowngradeDelete),
  );
}

Future<void> configure(Database database) async {
  await database.rawQuery("PRAGMA journal_mode = WAL");
}
