part of 'calendar_data_bloc.dart';

@freezed
class CalendarDataEvent with _$CalendarDataEvent {
  const factory CalendarDataEvent.getWorkEntry(DateTime date) = _GetWorkEntry;
  const factory CalendarDataEvent.saveWorkEntry(WorkEntry workEntry) = _SaveWorkEntry;
  const factory CalendarDataEvent.deleteWorkEntry(WorkEntry workEntry) = _DeleteWorkEntry;
  const factory CalendarDataEvent.updateWorkEntry(WorkEntry workEntry) = _UpdateWorkEntry;
}