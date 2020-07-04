import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './Constants/theme.dart';
import './Views/login.view.dart';

void main() => {
      WidgetsFlutterBinding.ensureInitialized(),
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: primaryColor),
      ),
      runApp(MyApp()),
    };

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order App',
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
