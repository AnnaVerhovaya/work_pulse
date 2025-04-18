import 'package:flutter_application_workpulse/packages/src/model/models.dart';

abstract class WorkEntryDBRepository {
  WorkEntryDBRepository._();
  Future<void> insertWorkEntry(WorkEntry workEntry);
  Future<void> updateWorkEntry(WorkEntry workEntry);
  Future<void> deleteWorkEntry(int id);
  Future<WorkEntry?> getWorkEntryByDate(DateTime date);
  Future<List<WorkEntry>> getWorkEntriesForMonth(int year, int month);
  Future<double> getTotalIncomeForMonth(int year, int month);
  Future<double> getTotalHoursForMonth(int year, int month);
  Future<void> clearTable();
  Future<void> printDatabase();
  Future<void> recreateTable();
}