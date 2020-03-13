import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTitle extends StatelessWidget {

  final String text;

  const CustomTitle({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text, 
      style: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w400,
        fontSize: 20,
        letterSpacing: 0.7
      )
    );
  }

}