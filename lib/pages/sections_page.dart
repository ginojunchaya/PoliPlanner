import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        drawer: SideMenu()        
    );
  }

}