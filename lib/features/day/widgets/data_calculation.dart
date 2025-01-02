import 'package:flutter/material.dart';

class DataCalculationWidget extends StatelessWidget {
  const DataCalculationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:  Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      height: MediaQuery.of(context).size.height * 0.35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(mainAxisSize: MainAxisSize.min, children: [
            HoursWidget(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            CostWidget(),
          ]),
          SizedBox(height: MediaQuery.of(context).size.width * 0.20),
          SumWidget(),
        ],
      ),
    );
  }
}

class HoursWidget extends StatelessWidget {
  const HoursWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.35,
        height: MediaQuery.of(context).size.height * 0.05,
        child: TextField(
          decoration: InputDecoration(
              fillColor: Color(0xFFFFEFD6),
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: "часы"),
        ));
  }
}

class CostWidget extends StatelessWidget {
  const CostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.35,
        height: MediaQuery.of(context).size.height * 0.05,
        child: TextField(
          decoration: InputDecoration(
              fillColor: Color(0xFFFFEFD6),
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: "ставка в час"),
        ));
  }
}

class SumWidget extends StatelessWidget {
  const SumWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.35,
        height: MediaQuery.of(context).size.height * 0.05,
        child: TextField(
          decoration: InputDecoration(
              fillColor: Color(0xFFFFEFD6),
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: "итого"),
        ));
  }
}
