import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'logic/logic.dart';
import 'widgets/widgets.dart';

@RoutePage()
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return ChangeNotifierProvider(
      create: (context) => CalendarProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            DateFormat('MMMM').format(
              DateTime.now(),
            ),
            style: TextStyle(
                color: color,
                fontSize: 35,
                fontWeight: FontWeight.w400),
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Consumer<CalendarProvider>(
          builder: (context, calendarProvider, child) {
            return Scaffold(
              backgroundColor: color,
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TopCalendarWidget(),
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: CustomCalendar(
                      year: calendarProvider.year,
                      month: calendarProvider.month,
                      calendarDates: calendarProvider.calendarDates,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
