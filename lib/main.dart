import 'package:flutter/material.dart';
import 'package:poliplanner/pages/about_page.dart';
import 'package:poliplanner/pages/calculator_page.dart';
import 'package:poliplanner/pages/calendar_page.dart';
import 'package:poliplanner/pages/crear_step_five.dart';
import 'package:poliplanner/pages/crear_step_fourth.dart';
import 'package:poliplanner/pages/crear_step_one.dart';
import 'package:poliplanner/pages/crear_step_three.dart';
import 'package:poliplanner/pages/crear_step_two.dart';
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
        "about" : (context) => AboutPage(),
        "crear_step_one" : (context) => CrearStepOne(),
        "crear_step_two" : (context) => CrearStepTwo(),
        "crear_step_three" : (context) => CrearStepThree(),
        "crear_step_fourth" : (context) => CrearStepFourth(),
        "crear_step_five" : (context) => CrearStepFive()
      },
      debugShowCheckedModeBanner: false
    );
  }
}
