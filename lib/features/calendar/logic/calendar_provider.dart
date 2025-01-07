import 'package:flutter/material.dart';
import 'package:flutter_application_workpulse/services/calendar_service.dart';
import 'package:intl/intl.dart';

class CalendarProvider extends ChangeNotifier {
  int year = 0;
  int month = 0;
  List<DateTime> calendarDates = [];

  CalendarProvider() {
    initialState();
    _getData();
  }
  void initialState() {
    DateTime date = DateTime.now();
    month = int.parse(DateFormat('M').format(date));
    year = int.parse(DateFormat('y').format(date));
    notifyListeners();
  }

  void _getData() {
    calendarDates = getDates(year, month);
    notifyListeners();
  }

  List<DateTime> getDates(int year, int month) {
    CalendarService calendarService = CalendarService();
    var dates = calendarService.getDates(year, month);
    return dates;
  }
}
