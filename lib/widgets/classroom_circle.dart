

import 'package:flutter/material.dart';

class ClassRoomCircle extends StatelessWidget {

  final String title;

  const ClassRoomCircle({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(        
        shape: BoxShape.circle,
        color: Color.fromRGBO(63, 81, 180, 1)
      ),
      child: Center( 
        child: Text(
          title ?? "",
          style: TextStyle(color:  Colors.white, fontSize: 20),
          textAlign: TextAlign.center
        )
      )
    );
  }
  
}