import 'package:flutter/material.dart';

import 'main_menu.dart';
import 'theme_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainMenu(),
      title: "Japanese Quiz",
      theme: lightTheme,
    );
  }
}
