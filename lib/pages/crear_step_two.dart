import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poliplanner/core/xls-manager.dart';
import 'package:poliplanner/model/Asignatura.dart';
import 'package:poliplanner/model/Carrera.dart';
import 'package:poliplanner/model/Seccion.dart';
import 'package:poliplanner/model/Semestre.dart';
import 'package:poliplanner/widgets/side_menu.dart';
import 'package:poliplanner/widgets/title.dart';

class CrearStepTwo extends StatefulWidget {

  const CrearStepTwo(File file,
    List<Carrera> carrerasSeleccionadas,
    Function(List<Semestre>) updateSemestres) : this.updateSemestres = updateSemestres, this.carrerasSeleccionadas = carrerasSeleccionadas, this.file = file;

  final List<Carrera> carrerasSeleccionadas;
  final Function(List<Semestre>) updateSemestres;
  final File file;

  @override
  CrearStepTwoState createState() => CrearStepTwoState();

}

class CrearStepTwoState extends State<CrearStepTwo> {

  Carrera current;
  int currentPos;
  List<Semestre> semestres;

  @override
  void initState(){
    this.setState(() {
      semestres = List();
      currentPos = 0;
      current = widget.carrerasSeleccionadas[currentPos];
      XlsManager manager = XlsManager();
      manager.openFile(widget.file);
      this.semestres = manager.getSemesters(current);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: CupertinoButton(
            child: Icon(
              Icons.menu,
              color: Colors.black87
            ),
            onPressed:(){ ScaffoldState().openDrawer(); }
          ),
          backgroundColor: Colors.white,
          title: CustomTitle(text: "Crear horario")
        ),
        drawer: SideMenu(),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                child: Text("Paso 2: Selecciona las materias de ${current.codigo + (current.enfasis != null ? '-' + current.enfasis.codigo : '')}"),
                padding: EdgeInsets.all(15),
                color: Color(0xfff4f4f4),
                width: double.infinity,
              ),
              Expanded(
                child: ListView(
                  children: semestres.map((s) => ExpansionTile(
                    title: Text("Semestre ${s.numero}"),
                    trailing: Checkbox(value: s.selected, tristate: false, onChanged: (e){ this.selectSemestreCheck(e, s); },),                    
                    children: s.asignaturas.map((a) => ListTile(
                      title: Text(a.nombre, style: TextStyle(fontSize: 15)),
                      trailing: Checkbox(value: a.selected, tristate: false, onChanged: (e){this.selectAsignaturaCheck(e, a); },),
                    )).toList(),
                  )).toList()
                )
              )
            ]
          )
        ),
        bottomSheet: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CupertinoButton(
                child: Icon(Icons.arrow_back),
                onPressed: back
              ),
              CupertinoButton(
                child: Icon(Icons.arrow_forward),
                onPressed: next,
              )
            ],
          ),
        ),        
    );
  }

  next(){
    if(this.currentPos < (widget.carrerasSeleccionadas.length - 1)){
      this.nextCarrera();
    }
    else {
      widget.updateSemestres(this.filterSemestres());
      Navigator.pushNamed(context, "crear_step_three");
    }
  }

  back(){
    if(this.currentPos > 0){
      this.prevCarrera();
    }
    else {
      Navigator.pop(context);
    }    
  }

  List<Semestre> filterSemestres(){
    List<Semestre> filtered = List();
    for(Semestre semestre in semestres){
      if(semestre.selected || haveAsignaturasSelected(semestre.asignaturas)){
        filtered.add(semestre);
      }
    }
    return filtered;
  }

  bool haveAsignaturasSelected(List<Asignatura> asignaturas){
    for(Asignatura asignatura in asignaturas){
      if(asignatura.selected){
        return true;
      }
    }
    return false;
  }

  selectSemestreCheck(e, Semestre semestre){
    this.setState(() {
      semestre.selected = !semestre.selected;
      for(Asignatura asignatura in semestre.asignaturas){
        asignatura.selected = semestre.selected;
      }
    });
  }  

  selectAsignaturaCheck(e, Asignatura asignatura){
    this.setState(() {
      asignatura.selected = !asignatura.selected;
    });
  }

  nextCarrera(){
    this.setState(() {
      this.currentPos++;
      this.current = widget.carrerasSeleccionadas[currentPos];      
      XlsManager manager = XlsManager();
      manager.openFile(widget.file);
      this.semestres = manager.getSemesters(current);
    });
  }

  prevCarrera(){
    this.setState(() {
      this.currentPos--;
      this.current = widget.carrerasSeleccionadas[currentPos];
      XlsManager manager = XlsManager();
      manager.openFile(widget.file);
      this.semestres = manager.getSemesters(current);
    });
  }

}