import 'package:flutter/material.dart';
import './screens/mainpage.dart';
import './UI/theme.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Admin App',
      theme: new ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryColor,
        accentColor: accentColor,
      ),
      debugShowCheckedModeBanner: false,
      home: new MainPage(),
    );
  }
}