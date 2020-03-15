import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poliplanner/widgets/side_menu.dart';
import 'package:poliplanner/widgets/title.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarioPage extends StatefulWidget {

  @override
  CalendarioPageState createState() => CalendarioPageState();

}

class CalendarioPageState extends State<CalendarioPage> {

  CalendarController _calendarController;

  @override
  void initState(){
    _calendarController = CalendarController();    
    super.initState();
  }

  @override
  void dispose(){
    _calendarController.dispose();
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
          backgroundColor: Colors.white,
          title: CustomTitle(text: "Calendario")
        ),
        drawer: SideMenu(),
        body: SafeArea(
          child: TableCalendar(
            calendarController: _calendarController,
          )
        ),
      );    
  }

}