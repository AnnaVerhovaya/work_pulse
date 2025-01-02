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

  Future<List<WorkEntry?>> getWorkEntriesForMonth(DateTime month) async {
    return await workEntryDB.getWorkEntriesForMonth(month);
  }

  Future<double> getTotalIncomeForMonth(DateTime month) async {
    return await workEntryDB.getTotalIncomeForMonth(month);
  }
   Future<double> getTotalHoursForMonth(DateTime month) async {
    return await workEntryDB.getTotalHoursForMonth(month);
  }
 
}
