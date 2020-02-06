import 'package:flutter/material.dart';
import 'package:japanese_quiz/app_data.dart';
import 'package:provider/provider.dart';

import 'main_menu.dart';
import 'theme_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppData(),
      child: MaterialApp(
        home: MainMenu(),
        title: "Japanese Quiz",
        theme: lightTheme,
        routes: <String, WidgetBuilder> {
          
        },
      ),
    );
  }
}
