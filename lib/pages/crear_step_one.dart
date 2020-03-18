import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poliplanner/core/xls-manager.dart';
import 'package:poliplanner/model/Carrera.dart';
import 'package:poliplanner/widgets/side_menu.dart';
import 'package:poliplanner/widgets/title.dart';

class CrearStepOne extends StatefulWidget {

  const CrearStepOne(File file,
    Function(List<Carrera>) updateCarreras, 
    Function(List<Carrera>) seleccionarCarreras) : this.file = file, this.updateCarreras = updateCarreras, this.seleccionarCarreras = seleccionarCarreras;

  final File file;
  final Function(List<Carrera>) updateCarreras;
  final Function(List<Carrera>) seleccionarCarreras;

  @override
  CrearStepOneState createState() => CrearStepOneState();
}

class CrearStepOneState extends State<CrearStepOne> {

  XlsManager manager;
  List<Carrera> carreras = List();
  List<Carrera> seleccionadas = List();

  @override
  void initState() {
    manager = XlsManager();
    this.openFile();
    super.initState();
  }

  openFile() async {
    this.setState(() {
      manager.openFile(widget.file);
      carreras = manager.getCarrer();
    });
    widget.updateCarreras(carreras);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: CupertinoButton(
            child: Icon(Icons.menu, color: Colors.black87),
            onPressed: () {
              ScaffoldState().openDrawer();
            }),
          backgroundColor: Colors.white,
          title: CustomTitle(text: "Crear horario")),
      drawer: SideMenu(),
      body: SafeArea(
        child: Column(
        children: <Widget>[
          Container(
            child: Text("Paso 1: Selecciona tu(s) carrera(s)"),
            padding: EdgeInsets.all(15),
            color: Color(0xfff4f4f4),
            width: double.infinity,
          ),
          Expanded(
            child: ListView(
              children: carreras
                  .map(
                    (Carrera c) => ListTile(
                      title: Text(
                        c.nombre +
                            (c.enfasis == null
                                ? ""
                                : " con énfasis en ${c.enfasis.nombre}"),
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Checkbox(
                        onChanged: (e){this.selectCheck(e, c);},
                        tristate: false,
                        value: c.selected,
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      )),
      bottomSheet: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CupertinoButton(child: Icon(Icons.arrow_back), onPressed: null),
            CupertinoButton(
              child: Icon(Icons.arrow_forward),
              onPressed: nextPage,
            )
          ],
        ),
      ),
    );
  }

  selectCheck(e, Carrera carrera){
    this.setState(() {
      carrera.selected = !carrera.selected;      
    });
  }

  List<Carrera> filterSelected (){
    List<Carrera> filtered = List();
    for(Carrera carrera in carreras){
      if(carrera.selected){
        filtered.add(carrera);
      }
    }
    return filtered;
  }

  void nextPage(){
    widget.seleccionarCarreras(this.filterSelected());
    Navigator.pushNamed(context, "crear_step_two");
  }

}
