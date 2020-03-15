
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poliplanner/widgets/side_menu.dart';
import 'package:poliplanner/widgets/title.dart';

class HomePage extends StatefulWidget {

  const HomePage({ Key key }) : super(key: key);

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

  TabController _tabController;
  File _document;

  @override
  void initState(){
    super.initState();
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
          child: Icon(
            Icons.menu,
            color: Colors.black87
          ),
          onPressed:(){ ScaffoldState().openDrawer(); }
        ),
        actions: <Widget>[
          CupertinoButton(
            child: Icon(
              Icons.refresh,
              color: Colors.black54
            ),
            onPressed: (){},
          ),
          CupertinoButton(
            child: Icon(
              Icons.file_upload,
              color: Colors.black54
            ),
            onPressed: this.openDocument,
          ),
          CupertinoButton(
            child: Icon(
              Icons.settings,
              color: Colors.black54
            ),
            onPressed: (){},
          ),                    
        ],
        backgroundColor: Colors.white,
        title: CustomTitle(text: "PoliPlanner"),
        bottom: TabBar(
          isScrollable: true,
          labelColor: Colors.black87,
          controller: _tabController,
          tabs: myTabs
        ),          
      ),
      drawer: SideMenu(),
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          final String label = tab.text.toLowerCase();
          return Center(
            child: Text(
              'This is the $label tab',
              style: const TextStyle(fontSize: 36, color: Colors.black87),
            ),
          );
        }).toList(),
      ),
    );
  }

  openDocument() async {
    this.setState(() async {
      _document = await FilePicker.getFile();      
    });
  }


}