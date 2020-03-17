import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poliplanner/widgets/side_menu.dart';
import 'package:poliplanner/widgets/title.dart';

class CrearStepFive extends StatefulWidget {

  @override
  CrearStepFiveState createState() => CrearStepFiveState();

}

class CrearStepFiveState extends State<CrearStepFive> {

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
        drawer: SideMenu()
    );
  }

}