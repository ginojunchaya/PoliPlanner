import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poliplanner/widgets/side_menu.dart';
import 'package:poliplanner/widgets/title.dart';

class CrearStepTwo extends StatefulWidget {

  @override
  CrearStepTwoState createState() => CrearStepTwoState();

}

class CrearStepTwoState extends State<CrearStepTwo> {

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