import 'dart:io';

import 'package:flutter/material.dart';
import 'package:poliplanner/pages/about_page.dart';
import 'package:poliplanner/pages/calculator_page.dart';
import 'package:poliplanner/pages/calendar_page.dart';
import 'package:poliplanner/pages/crear_step_one.dart';
import 'package:poliplanner/pages/crear_step_three.dart';
import 'package:poliplanner/pages/crear_step_two.dart';
import 'package:poliplanner/pages/home_page.dart';
import 'package:poliplanner/pages/sections_page.dart';

import 'model/Asignatura.dart';
import 'model/Carrera.dart';
import 'model/Semestre.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  List<Carrera> _carreras;
  List<Carrera> _carrerasSeleccionadas;  
  List<Semestre> _semestres;
  List<Asignatura> _asignaturas;
  File _file;

  @override
  void initState(){
    this._carreras = List();
    this._carrerasSeleccionadas = List();
    this._semestres = List();
    this._asignaturas = List();
    this._file = null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "home",
      routes: {
        "home": (context) => HomePage(updateFile),
        "calendar" : (context) => CalendarioPage(),
        "sections" : (context) => SectionsPage(),
        "calculator" : (context) => CalculatorPage(),
        "about" : (context) => AboutPage(),
        "crear_step_one" : (context) => CrearStepOne(_file, updateCarreras, seleccionarCarreras),
        "crear_step_two" : (context) => CrearStepTwo(_file, _carrerasSeleccionadas, updateSemestres),
        "crear_step_three" : (context) => CrearStepThree(_asignaturas)
      },
      debugShowCheckedModeBanner: false
    );
  }

  updateFile(file){
    this.setState(() {
      this._file = file;      
    });
  }

  updateCarreras(carreras){
    this.setState(() {
      this._carreras = carreras;      
    });
  }

  updateSemestres(semestres){
    this.setState(() {
      this._semestres = semestres;
      this._asignaturas = this.extractAsignaturas(semestres);
    });
  }

  List<Asignatura> extractAsignaturas(List<Semestre> semestres){
    List<Asignatura> asignaturas = List();
    for(Semestre semestre in semestres){
      for(Asignatura asignatura in semestre.asignaturas){
        if(asignatura.selected){
          asignaturas.add(asignatura);
        }
      }
    }
    return asignaturas;
  }

  seleccionarCarreras(carreras){
    this.setState(() {
      this._carrerasSeleccionadas = carreras;
    });
  }

}
