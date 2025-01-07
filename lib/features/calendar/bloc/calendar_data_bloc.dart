import 'package:bloc/bloc.dart';
import 'package:flutter_application_workpulse/packages/src/model/models.dart';
import 'package:flutter_application_workpulse/services/work_entry_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_data_event.dart';
part 'calendar_data_state.dart';
part 'calendar_data_bloc.freezed.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final WorkEntryService workEntryService;

  CalendarBloc(this.workEntryService) : super(const CalendarState.initial()) {
 on<_GetWorkEntry>((event, emit) async {
  emit(const CalendarState.loading());
  try {
    final workEntry = await workEntryService.getWorkEntry(event.date);
    final currentState = state;


    if (currentState is _Loaded) {
    
      final updatedEntries = Map<DateTime, WorkEntry?>.from(currentState.workEntries);
      updatedEntries[event.date] = workEntry; 
      emit(CalendarState.loaded(updatedEntries));
    } else {
      emit(CalendarState.loaded({event.date: workEntry}));
    }
  } catch (e) {
    final currentState = state;
    if (currentState is _Loaded) {
      final updatedEntries = Map<DateTime, WorkEntry?>.from(currentState.workEntries);
      updatedEntries[event.date] = null;
      emit(CalendarState.loaded(updatedEntries));
    } else {
      emit(CalendarState.error(e.toString()));
    }
  }
});
    on<_AddWorkEntry>((event, emit) async {
      try {
        await workEntryService.insertWorkEntry(event.workEntry);
      } catch (e) {
        emit(CalendarState.error(e.toString()));
      }
    });

    on<_DeleteWorkEntry>((event, emit) async {
      emit(const CalendarState.loading());
      try {
        await workEntryService.deleteWorkEntry(event.workEntry.id);
      } catch (e) {
        emit(CalendarState.error(e.toString()));
      }
    });

    on<_UpdateWorkEntry>((event, emit) async {
      emit(const CalendarState.loading());
      try {
        await workEntryService.updateWorkEntry(event.workEntry);
      } catch (e) {
        emit(CalendarState.error(e.toString()));
      }
    });
  }
}
