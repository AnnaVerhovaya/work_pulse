import 'package:flutter/material.dart';
import 'package:flutter_application_workpulse/router/router.dart';
import 'package:flutter_application_workpulse/utils/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color seedColor = AppConstants().mainColor;

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter();
    return MaterialApp.router(
      routerConfig: router.config(),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: seedColor, primary: seedColor, secondary: seedColor),
        useMaterial3: true,
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w400,
          ),
          displayMedium: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF6699CC),
          ),
          displaySmall: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
        ),
      ),
    );
  }
}
