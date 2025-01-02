import 'package:bloc/bloc.dart';
import 'package:flutter_application_workpulse/packages/src/model/models.dart';
import 'package:flutter_application_workpulse/services/work_entry_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_data_event.dart';
part 'calendar_data_state.dart';
part 'calendar_data_bloc.freezed.dart';

class CalendarDataBloc extends Bloc<CalendarDataEvent, CalendarDataState> {
  final WorkEntryService workEntryService;

  CalendarDataBloc(this.workEntryService) : super(const CalendarDataState.initial()) {
    
    on<_GetWorkEntry>((event, emit) async {
      emit(const CalendarDataState.loading());
      try {
        final workEntry = await workEntryService.getWorkEntry(event.date);
        if (workEntry != null) {
          emit(CalendarDataState.loaded(workEntry)); 
        } else {
          emit(const CalendarDataState.error('Запись не найдена'));
        }
      } catch (e) {
        emit(CalendarDataState.error(e.toString()));
      }
    });

    on<_SaveWorkEntry>((event, emit) async {
      emit(const CalendarDataState.loading());
      try {
        await workEntryService.insertWorkEntry(event.workEntry);
      } catch (e) {
        emit(CalendarDataState.error(e.toString()));
      }
    });

    on<_DeleteWorkEntry>((event, emit) async {
      emit(const CalendarDataState.loading());
      try {
        await workEntryService.deleteWorkEntry(event.workEntry.id);
      
      } catch (e) {
        emit(CalendarDataState.error(e.toString()));
      }
    });

    on<_UpdateWorkEntry>((event, emit) async {
      emit(const CalendarDataState.loading());
      try {
        await workEntryService.updateWorkEntry(event.workEntry);
       
      } catch (e) {
        emit(CalendarDataState.error(e.toString()));
      }
    });
  }
}