import 'package:flutter/material.dart';

class TopCalendarWidget extends StatelessWidget {
  const TopCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45), bottomLeft: Radius.circular(45)),
          gradient: LinearGradient(
            colors: [
              Color(0xFF306afa),
              Color(0xFF1d5dfa),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '75тыс.р/',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              '60 часов',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
