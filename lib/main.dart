import 'package:flutter/material.dart';
import 'package:poliplanner/pages/about_page.dart';
import 'package:poliplanner/pages/calculator_page.dart';
import 'package:poliplanner/pages/calendar_page.dart';
import 'package:poliplanner/pages/home_page.dart';
import 'package:poliplanner/pages/sections_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "home",
      routes: {
        "home": (context) => HomePage(),
        "calendar" : (context) => CalendarioPage(),
        "sections" : (context) => SectionsPage(),
        "calculator" : (context) => CalculatorPage(),
        "about" : (context) => AboutPage()
      },
      debugShowCheckedModeBanner: false
    );
  }
}
