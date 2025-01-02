part of 'calendar_data_bloc.dart';

@freezed
class CalendarDataState with _$CalendarDataState {
  const factory CalendarDataState.initial() = _Initial;
  const factory CalendarDataState.loading() = _Loading;
  const factory CalendarDataState.error(String message) = _Error;
  const factory CalendarDataState.loaded(WorkEntry workEntry) = _Loaded;
}
