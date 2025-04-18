part of 'calendar_data_bloc.dart';

@freezed
class CalendarEvent with _$CalendarEvent {
  const factory CalendarEvent.getWorkEntry(DateTime date) = _GetWorkEntry;
  const factory CalendarEvent.getWorkEntryForMounth(int year, int month) = _GetWorkEntryForMounth;
  const factory CalendarEvent.getTotalIncomeForMonth(int year, int month) = _GetTotalIncomeForMonth;
  const factory CalendarEvent.getTotalHoursForMonth(int year, int month) = _GetTotalHoursForMonth;
  const factory CalendarEvent.addWorkEntry(WorkEntry workEntry) = _AddWorkEntry;
  const factory CalendarEvent.deleteWorkEntry(WorkEntry workEntry) = _DeleteWorkEntry;
  const factory CalendarEvent.updateWorkEntry(WorkEntry workEntry) = _UpdateWorkEntry;
}