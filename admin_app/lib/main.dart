import 'package:flutter/material.dart';

import './Constants/theme.dart';
import './Views/login.view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin App',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryColor,
        accentColor: accentColor,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
