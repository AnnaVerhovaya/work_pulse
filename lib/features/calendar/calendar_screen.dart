import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_workpulse/features/calendar/calendar_widget.dart';
import 'package:flutter_application_workpulse/services/calendar_service.dart';
import 'package:intl/intl.dart';
import 'widgets/index.dart';

@RoutePage()
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int year = 0;
  int month = 0;
  int day = 0;
  List<DateTime> dates = [];
  var calendarDates = [];
  var color = const Color(0xFF0033cc);

  @override
  void initState() {
    initialState();
    _getData(month: month, year: year);
    super.initState();
  }

  initialState() {
    DateTime date = DateTime.now();
    month = int.parse(DateFormat('M').format(date));
    year = int.parse(DateFormat('y').format(date));
    setState(() {});
  }

  _getData({int? month, int? year}) async {
  month ??= this.month;
  year ??= this.year;
  CalendarService calendarService = CalendarService();
  calendarDates = calendarService.getDates(year, month);
  setState(() {});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateFormat('MMMM').format(
            DateTime.now(),
          ),
          style: TextStyle(
              color: color, fontSize: 35, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Scaffold(
        backgroundColor: color,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
           const TopCalendarWidget(),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: CustomCalendar(
                year: year,
                month: month,
                calendarDates: calendarDates,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
