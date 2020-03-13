import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poliplanner/widgets/side_menu.dart';
import 'package:poliplanner/widgets/title.dart';

class CalendarioPage extends StatefulWidget {

  @override
  CalendarioPageState createState() => CalendarioPageState();

}

class CalendarioPageState extends State<CalendarioPage> {

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
        drawer: SideMenu()        
    );
  }

}