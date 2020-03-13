import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              margin: EdgeInsets.only(bottom: 20),
              alignment: Alignment.center,
              child: Image.asset("assets/images/png/logo.png", width: 100,),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                boxShadow: [BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 2)
                )]
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: ModalRoute.of(context).settings.name == "home" ? Colors.blue : null),
              title: Text("Inicio"),
              onTap: (){ Navigator.pushReplacementNamed(context, "home"); },
            ),
            ListTile(
              leading: Icon(Icons.library_books, color: ModalRoute.of(context).settings.name == "sections" ? Colors.blue : null),
              title: Text("Secciones"),
              onTap: (){ Navigator.pushReplacementNamed(context, "sections"); },
            ),              
            ListTile(
              leading: Icon(Icons.calendar_today, color: ModalRoute.of(context).settings.name == "calendar" ? Colors.blue : null),
              title: Text("Calendario"),
              onTap: (){ Navigator.pushReplacementNamed(context, "calendar"); },
            ),
            ListTile(
              leading: Icon(Icons.phone_android, color: ModalRoute.of(context).settings.name == "calculator" ? Colors.blue : null),
              title: Text("Calculadora"),
              onTap: (){ Navigator.pushReplacementNamed(context, "calculator"); },
            ),
            ListTile(
              leading: Icon(Icons.info, color: ModalRoute.of(context).settings.name == "about" ? Colors.blue : null),
              title: Text("Acerca de"),
              onTap: (){ Navigator.pushReplacementNamed(context, "about"); },
            ),              
          ],
        ),
      )
    );
  }

}