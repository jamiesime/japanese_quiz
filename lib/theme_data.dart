import 'package:flutter/material.dart';

var zeroAlpha = Color.fromARGB(0, 0, 0, 0);

var lightTheme = ThemeData(
  backgroundColor: Color.fromARGB(255, 180, 175, 143),
  accentColor: Colors.teal[100],
  primaryColor: Color.fromARGB(255, 216, 214, 195),
  textTheme: TextTheme(
    headline: TextStyle(
      fontSize: 60,
      fontFamily: 'Antipasto',
      color: Colors.white,
    ),
    title: TextStyle(
      fontSize: 40,
      fontFamily: 'Antipasto',
      color: Colors.black,
    ),
    display1: TextStyle(
      fontSize: 60,
      fontFamily: 'Antipasto',
      color: Colors.white,
    ),
    body1: TextStyle(
      fontSize: 30,
      fontFamily: 'Antipasto',
      color: Colors.black,
    ),
    body2: TextStyle(
      fontSize: 40,
      fontFamily: 'Roboto',
      color: Colors.black,
    ),
    button:TextStyle(
      fontSize: 25,
      fontFamily: 'Roboto',
      color: Colors.black26,
    ),
  ),
);
