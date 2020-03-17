import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poliplanner/core/xls-manager.dart';
import 'package:poliplanner/model/Carrera.dart';
import 'package:poliplanner/widgets/side_menu.dart';
import 'package:poliplanner/widgets/title.dart';

class CrearStepOne extends StatefulWidget {

  @override
  CrearStepOneState createState() => CrearStepOneState();

}

class CrearStepOneState extends State<CrearStepOne> {

  File file;
  XlsManager manager;
  List<Carrera> carreras = List();

  @override
  void initState() {
    manager = XlsManager();
    this.openFile();
    super.initState();
  }

  openFile() async {
    this.setState(() async {
      this.file = await FilePicker.getFile();
      manager.openFile(this.file);
      carreras = manager.getCarrer();
    });
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
          child: ListView(
            children: carreras.map((Carrera e) =>
              ListTile(
                title: Text(e.nombre),
                subtitle: Text(e.enfasis != null ? e.enfasis.toString() : ""),
                trailing: Checkbox(tristate: false, value: true,),)
            ).toList(),
          )
        ),
    ) ;
  }

}