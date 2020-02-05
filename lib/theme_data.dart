import 'package:flutter/material.dart';

var zeroAlpha = Color.fromARGB(0, 0, 0, 0);

var lightTheme = ThemeData(
  backgroundColor: Color.fromARGB(255, 180, 175, 143),
  accentColor: Colors.teal[100],
  primaryColor: Color.fromARGB(255, 216, 214, 195),
  textTheme: TextTheme(
    headline: TextStyle(
      fontSize: 60,
      fontFamily: 'Roboto',
      color: Colors.white,
    ),
    title: TextStyle(
      fontSize: 40,
      fontFamily: 'Roboto',
      color: Colors.black,
    ),
    display1: TextStyle(
      fontSize: 50,
      fontFamily: 'Roboto',
      color: Colors.white,
    ),
    body1: TextStyle(
      fontSize: 30,
      fontFamily: 'Roboto',
      color: Colors.black,
    ),
  ),
);
