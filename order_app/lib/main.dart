import 'package:flutter/material.dart';
import './Views/mainpage.view.dart';
import './Constants/theme.dart';
import './Models/connectServer.dart';
void main() {
   runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  final x = MySqlConnection.instance.login(user: 'tvc12', pass: '12782389');

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
      home: new MainPage(),
    );
  }
}
