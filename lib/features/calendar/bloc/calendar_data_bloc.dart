import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_workpulse/packages/src/model/models.dart';
import 'package:flutter_application_workpulse/services/work_entry_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_data_event.dart';
part 'calendar_data_state.dart';
part 'calendar_data_bloc.freezed.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final WorkEntryService workEntryService;

  CalendarBloc(this.workEntryService) : super(const CalendarState.initial()) {
    // on<_GetWorkEntry>((event, emit) async {
    //   emit(const CalendarState.loading());
    //   try {
    //     final workEntry = await workEntryService.getWorkEntry(event.date);
    //     final currentState = state;
    //     if (currentState is _Loaded) {
    //       final updatedEntries =
    //           Map<DateTime, WorkEntry?>.from(currentState.workEntries);
    //       updatedEntries[event.date] = workEntry;
    //       emit(CalendarState.loaded(updatedEntries));
    //     } else {
    //       emit(CalendarState.loaded({event.date: workEntry}));
    //     }
    //   } catch (e) {
    //     final currentState = state;
    //     if (currentState is _Loaded) {
    //       final updatedEntries =
    //           Map<DateTime, WorkEntry?>.from(currentState.workEntries);
    //       updatedEntries[event.date] = null;
    //       emit(CalendarState.loaded(updatedEntries));
    //     } else {
    //       emit(CalendarState.error(e.toString()));
    //     }
    //   }
    // });
    WorkEntry _getEmptyEntry(DateTime date) {
      return WorkEntry(
        id: -1,
        date: date,
        hoursWorked: 0,
        hourRate: 0,
        totalIncome: 0,
        isWorkingDay: true,
      );
    }

    List<WorkEntry> _createFullMonthEntries({
      required int year,
      required int month,
      required List<WorkEntry>? actualEntries,
    }) {
      final daysInMonth = DateUtils.getDaysInMonth(year, month);
      final entriesMap = {
        for (var e in actualEntries?.whereType<WorkEntry>() ?? <WorkEntry>[])
          e.date.day: e
      };

      return List.generate(daysInMonth, (index) {
        final currentDate = DateTime(year, month, index + 1);
        return entriesMap[currentDate.day] ?? _getEmptyEntry(currentDate);
      });
    }

    on<_GetWorkEntryForMounth>((event, emit) async {
      emit(const CalendarState.loading());
      try {
        final workEntry = await workEntryService.getWorkEntriesForMonth(
          event.year,
          event.month,
        );
        final fullMonthEntries = _createFullMonthEntries(
            actualEntries: workEntry, month: event.month, year: event.year);
        emit(CalendarState.loaded(fullMonthEntries));
      } catch (e) {
        emit(CalendarState.error(e.toString()));
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
