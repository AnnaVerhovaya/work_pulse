import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_workpulse/features/day/widgets/data_calculation.dart';
import 'package:intl/intl.dart';



@RoutePage()
class DayScreen extends StatelessWidget {
  const DayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.95,
            decoration:
                BoxDecoration(color: const Color(0xFF958DA5).withOpacity(0.5)),
          ),
          const DataCalculationWidget(),
          const TopScreenWidget(),
        ],
      ),
    );
  }
}

class TopScreenWidget extends StatelessWidget {
  const TopScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: const BoxDecoration(
        color: Color(0xFF465567),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DateWidget(),
          ResultMonthWidget(),
        ],
      ),
    );
  }
}

class DateWidget extends StatelessWidget {
  const DateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 24,
          ),
          child: Text(DateFormat.MMMd().format(DateTime.now()),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(DateFormat.EEEE().format(DateTime.now()),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              )),
        ),
      ],
    );
  }
}

class ResultMonthWidget extends StatelessWidget {
  const ResultMonthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: SizedBox(
        width: 150,
        height: 300,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 2,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFEFD6),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: const Center(
                    child: Text("78900 р"),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
