import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poliplanner/model/Asignatura.dart';
import 'package:poliplanner/model/Seccion.dart';
import 'package:poliplanner/widgets/classroom_circle.dart';
import 'package:poliplanner/widgets/side_menu.dart';
import 'package:poliplanner/widgets/title.dart';

class HomePage extends StatefulWidget {

  final Function(File) updateFile;
  final Map<String, List<Asignatura>> horario;

  const HomePage(void Function(File) updateFile, Map<String, List<Asignatura>> horario) : this.updateFile = updateFile, this.horario = horario;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'LUNES'),
    Tab(text: 'MARTES'),
    Tab(text: 'MIÉRCOLES'),
    Tab(text: 'JUEVES'),
    Tab(text: 'VIERNES'),
    Tab(text: 'SÁBADO')
  ];
  Map<String, List<Asignatura>> horario;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    horario = widget.horario;
    _tabController = TabController(length: myTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
        actions: <Widget>[
          CupertinoButton(
            child: Icon(Icons.file_upload, color: Colors.black54),
            onPressed: this.openDocument,
          )
        ],
        backgroundColor: Colors.white,
        title: CustomTitle(text: "PoliPlanner"),
        bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.black87,
            controller: _tabController,
            tabs: myTabs),
      ),
      drawer: SideMenu(),
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          final String label = tab.text.toLowerCase();
          return Center(
            child: (horario == null) ? Text(
              'No hay datos',
              style: const TextStyle(fontSize: 20, color: Colors.black87),
            ) : ListView(
              children: this.getChildren(tab),
            ),
          );
        }).toList(),
      ),
    );
  }

  List<Widget> getChildren(Tab tab){
    List<ListTile> listAll = List();
    horario.forEach((key, List<Asignatura> value) {
      if(key == tab.text){
        //print("$key == ${tab.text} : ${value.length}"); 
        for(Asignatura asignatura in value){
          ListTile item = ListTile(
            leading: ClassRoomCircle(title: ""),
            title: Text(asignatura.nombre),
            subtitle: Text(getHorario(asignatura.secciones, key)), onTap: (){},);
          listAll.add(item);
        }
      }
    });
    print(listAll);
    return listAll;
  }

  String getHorario(List<Seccion> secciones, String dia){
    String horario;
    for(Seccion seccion in secciones){
      if(seccion.selected){
        seccion.horarios.forEach((key, value) {
          if(key == dia){
            horario = value;
          }
        });
        break;
      }
    }    
    return horario;
  }

  openDocument() async {
    File file = await FilePicker.getFile();
    widget.updateFile(file);
    Navigator.pushNamed(context, "crear_step_one");
  }
  
}
