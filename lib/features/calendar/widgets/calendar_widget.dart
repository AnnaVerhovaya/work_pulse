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
  final List<DateTime> calendarDates;

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

bool _isSwitched = false;
final workEntryDB = WorkEntryService(WorEntryDataBase());

class _CustomCalendarState extends State<CustomCalendar> {
  final _hoursController = TextEditingController();
  final _rateController = TextEditingController();
  late CalendarBloc calendarBloc;
  double? hoursWorked;
  double? hourRate;

  @override
  void initState() {
    calendarBloc = CalendarBloc(WorkEntryService(WorEntryDataBase()));
    _loadInitialData();
    super.initState();
  }

  @override
  void dispose() {
    _hoursController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    calendarBloc
        .add(CalendarEvent.getWorkEntryForMounth(widget.year, widget.month));
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
        border: Border.all(
          color: Colors.white10,
          width: 1.5,
        ),
      ),
      child: BlocBuilder<CalendarBloc, CalendarState>(
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
              return Center(
                child: MasonryGridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.calendarDates.length,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                  ),
                  itemBuilder: (context, index) {
                    final workEntry = workEntries[index];
                    return calendarItem(context, index, workEntry);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Padding calendarItem(BuildContext context, int index, WorkEntry? workEntry) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: GestureDetector(
        onTap: () {
          addDataWidget(
            context,
            index,
            _isSwitched,
            workEntry,
          );
        },
        child: Column(
          children: [
            if (index < 7) Text(AppConstants().week[index]),
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text(
                    DateFormat('d').format(
                      widget.calendarDates[index],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 61, 93, 189),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        style: TextStyle(color: Colors.white),
                        workEntry?.totalIncome != null
                            ? workEntry!.totalIncome.toString()
                            : '',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> addDataWidget(
    BuildContext context,
    int index,
    bool isSwitched,
    WorkEntry? workEntry,
  ) {
    if (workEntry != null) {
      _hoursController.text = workEntry.hoursWorked.toString();
      _rateController.text = workEntry.hourRate.toString();
      _isSwitched = workEntry.isWorkingDay;
    }
    final mediaQuery = MediaQuery.of(context);
    final availableHeight =
        mediaQuery.size.height - mediaQuery.viewInsets.bottom;
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: availableHeight * 0.5,
            ),
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      style: const TextStyle(fontSize: 20),
                      DateFormat('d MMMM EEE').format(
                        widget.calendarDates[index],
                      ),
                    ),
                    TextField(
                      controller: _hoursController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          hoursWorked = double.parse(value);
                        });
                      },
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
                        hintText: 'введите часы',
                        labelStyle: const TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _rateController,
                      onChanged: (value) {
                        setState(() {
                          hourRate = double.parse(value);
                        });
                      },
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
                        const Text('Выходной день'),
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
                          final newEntry = WorkEntry(
                              id: DateTime.now().millisecondsSinceEpoch,
                              date: widget.calendarDates[index],
                              hoursWorked:
                                  hoursWorked != null ? hoursWorked! : 0.0,
                              hourRate: hourRate != null ? hourRate! : 0,
                              totalIncome: hoursWorked! * hourRate!,
                              isWorkingDay: !_isSwitched);
                          workEntry != null
                              ? calendarBloc.add(
                                  CalendarEvent.updateWorkEntry(newEntry),
                                )
                              : calendarBloc.add(
                                  CalendarEvent.addWorkEntry(newEntry),
                                );
                          _loadInitialData();
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
        ),
      ),
    );
  }

  getWorkEntry(calendarDat) {
    return workEntryDB.getWorkEntry(calendarDat);
  }
}
