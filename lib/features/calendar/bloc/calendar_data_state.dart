part of 'calendar_data_bloc.dart';

@freezed
class CalendarState with _$CalendarState {
  const factory CalendarState.initial() = _Initial;
  
  const factory CalendarState.loading() = _Loading;

  const factory CalendarState.error(String message) = _Error;

  const factory CalendarState.loaded(Map<DateTime, WorkEntry?> workEntries) = _Loaded;
}