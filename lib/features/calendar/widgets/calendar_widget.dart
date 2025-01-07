import 'dart:math';

import 'package:flutter_application_workpulse/database/work_entry_db.dart';
import 'package:flutter_application_workpulse/services/work_entry_service.dart';
import 'package:flutter_application_workpulse/utils/constants.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../packages/src/model/models.dart';
import '../bloc/bloc.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar(
      {super.key,
      required this.year,
      required this.month,
      required this.calendarDates});

  final int year;
  final int month;
  final calendarDates;

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

bool _isSwitched = false;
final workEntryDB = WorkEntryService(WorEntryDataBase());

class _CustomCalendarState extends State<CustomCalendar> {
  late CalendarBloc calendarBloc;

  @override
  void initState() {
    calendarBloc = CalendarBloc(WorkEntryService(WorEntryDataBase()));
    for (var date in widget.calendarDates) {
      calendarBloc.add(CalendarEvent.getWorkEntry(date));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: MasonryGridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.calendarDates.length,
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: () {
                  addDataWidget(context, index, _isSwitched);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (index < 7)
                      Text(
                        AppConstants().week[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    const SizedBox(height: 20),
                    Container(
                      height: 85,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.9),
                            blurRadius: 10,
                            offset: const Offset(5, 5),
                          ),
                          const BoxShadow(
                            color: Colors.white,
                            blurRadius: 10,
                            offset: Offset(-5, -5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            DateFormat('d').format(widget.calendarDates[index]),
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          BlocBuilder<CalendarBloc, CalendarState>(
                            bloc: calendarBloc,
                            builder: (context, state) {
                              return state.when(
                                initial: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                error: (message) => Center(
                                  child: Text(message),
                                ),
                                loaded: (workEntries) {
                                  final workEntry = workEntries[
                                          widget.calendarDates[index]] ??
                                      null;

                                  return Center(
                                    child: Text(
                                      style: Theme.of(context).textTheme.displaySmall,
                                      workEntry?.totalIncome != null
                                        ? workEntry!.totalIncome.toString()
                                        : ''),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> addDataWidget(
      BuildContext context, int index, bool isSwitched) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.45,
          width: MediaQuery.of(context).size.width * 0.3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  style: const TextStyle(fontSize: 20),
                  DateFormat('d').format(
                    widget.calendarDates[index],
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    fillColor: const Color(0xFF0033cc).withOpacity(0.1),
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 5,
                          color: Color(0xFF0033cc),
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    labelText: "часы",
                    labelStyle: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    fillColor: const Color(0xFF0033cc).withOpacity(0.1),
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 5,
                          color: Color(0xFF0033cc),
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    labelText: "ставка в час",
                    labelStyle: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text('Рабочий день'),
                    Switch(
                      value: _isSwitched,
                      onChanged: (value) {
                        setState(() {
                          _isSwitched = value;
                        });
                      },
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () async {
                      calendarBloc.add(
                        CalendarEvent.addWorkEntry(
                          WorkEntry(
                            id: DateTime.now().millisecondsSinceEpoch,
                            date: widget.calendarDates[index],
                            hoursWorked: 8.0,
                            hourRate: 15.0,
                            totalIncome: 120.0,
                            isWorkingDay: _isSwitched,
                          ),
                        ),
                      );

                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Сохранить",
                      style: TextStyle(
                        color: Color(0xFF0033cc),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getWorkEntry(calendarDat) {
    return workEntryDB.getWorkEntry(calendarDat);
  }
}
