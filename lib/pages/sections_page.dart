import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poliplanner/widgets/classroom_circle.dart';
import 'package:poliplanner/widgets/side_menu.dart';
import 'package:poliplanner/widgets/title.dart';

class SectionsPage extends StatefulWidget {

  @override
  SectionsPageState createState() => SectionsPageState();

}

class SectionsPageState extends State<SectionsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: CupertinoButton(
            child: Icon(
              Icons.menu,
              color: Colors.black87
            ),
            onPressed:(){ ScaffoldState().openDrawer(); }
          ),
          title: CustomTitle(text: "Secciones")
        ),
        drawer: SideMenu(),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text("Administración III"),
                subtitle: Text("Vicente Ramón Bracho Fleitas"),
                onTap: (){},
                leading: ClassRoomCircle(title: "A"),
                trailing: Text("NA"),
              ),
              ListTile(
                title: Text("Bases de Datos III"),
                subtitle: Text("Julio Manuel Paciello Coronel"),
                onTap: (){},
                leading: ClassRoomCircle(title: "A"),
                trailing: Text("NA"),
              ),
              ListTile(
                title: Text("Estadística y Probabilidades"),
                subtitle: Text("Rubén Castorino García Giménez"),
                onTap: (){},
                leading: ClassRoomCircle(title: "A"),
                trailing: Text("NA"),
              ),
              ListTile(
                title: Text("Ingeniería de Software I"),
                subtitle: Text("Ellen Luján Méndez Xavier"),
                onTap: (){},
                leading: ClassRoomCircle(title: "A"),
                trailing: Text("NA"),                
              ),
              ListTile(
                leading: ClassRoomCircle(title: "A"),
                trailing: Text("NA"),                
                title: Text("Matemática IV"),
                subtitle: Text("Irma Concepción Cardozo Olmedo"),
                onTap: (){},
              )              
            ],
          ),
        ),
    );
  }

}