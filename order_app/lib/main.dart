import 'package:flutter/material.dart';

import './Views/login.view.dart';

import './Constants/theme.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Order App',
      theme: new ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryColor,
        accentColor: accentColor,
      ),
      debugShowCheckedModeBanner: false,
      home: new LoginScreen(),
    );
  }
}
