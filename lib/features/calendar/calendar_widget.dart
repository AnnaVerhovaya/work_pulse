import 'package:flutter_application_workpulse/database/work_entry_db.dart';
import 'package:flutter_application_workpulse/packages/src/model/models.dart';
import 'package:flutter_application_workpulse/services/work_entry_service.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

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

List<String> day_of_the_week = [
  'пн',
  'вт',
  'ср',
  'чт',
  'пт',
  'сб',
  'вс',
];
bool _isSwitched = false;
final workEntryDB = WorkEntryService(WorEntryDataBase());

class _CustomCalendarState extends State<CustomCalendar> {
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
          )),
      child: Center(
        child: MasonryGridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.calendarDates.length,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                child: GestureDetector(
                  onTap: () {
                    addDataWidget(context, index, _isSwitched);
                  },
                  child: Column(
                    children: [
                      if (index < 7) Text(day_of_the_week[index]),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Column(
                          children: [
                            Text(
                              DateFormat('d').format(
                                widget.calendarDates[index],
                              ),
                            ),
                            FutureBuilder<WorkEntry?>(
                              future: getWorkEntry(widget.calendarDates[
                                  index]), // Ваш метод получения записи
                              builder: (BuildContext context,
                                  AsyncSnapshot<WorkEntry?> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator(); // Показать индикатор загрузки
                                } else if (snapshot.hasError) {
                                  return Text(
                                      'Ошибка: ${snapshot.error}'); // Обработка ошибок
                                } else if (!snapshot.hasData) {
                                  return Text(''); // Если данных нет
                                } else {
                                  // Если данные успешно получены
                                  WorkEntry entry = snapshot.data!;
                                  return Text(
                                    entry.totalIncome.toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: entry.totalIncome == 0
                                            ? Colors.black
                                            : Colors.red),
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
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
                        // await workEntryDB.insertWorkEntry(WorkEntry(
                        //   date: DateTime.now(),
                        //   hoursWorked: 8.0,
                        //   hourRate: 15.0,
                        //   totalIncome: 120.0,
                        //   isWorkingDay: _isSwitched,
                        // ));
                        // Navigator.pop(context);
                      },
                      child: const Text(
                        "Сохранить",
                        style: TextStyle(
                          color: Color(0xFF0033cc),
                        ),
                      )),
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
