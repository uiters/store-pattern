import 'package:flutter/material.dart';

const Color primaryColor = Color.fromARGB(255, 209, 228, 252);
const Color accentColor = Color.fromARGB(255, 72, 0, 250);
const Color fontColor = Color.fromARGB(255, 38, 54, 70);
const Color fontColorLight = Color.fromARGB(180, 38, 54, 70);

/* Dialog */
const TextStyle titleStyle =  TextStyle(
  color: accentColor,
  fontFamily: 'Dosis',
  fontSize: 19.0,
  fontWeight: FontWeight.w600
);
const TextStyle errorTitleStyle =  TextStyle(
  color: Colors.redAccent,
  fontFamily: 'Dosis',
  fontSize: 19.0,
  fontWeight: FontWeight.w600
);
const TextStyle contentStyle =  TextStyle(
  color: fontColor, 
  fontFamily: 'Dosis', 
  fontSize: 16.0,
  fontWeight: FontWeight.w500
);
const TextStyle okButtonStyle =  TextStyle(
  color: Colors.blueAccent, 
  fontFamily: 'Dosis', 
  fontSize: 16.0,
  fontWeight: FontWeight.w600
);
const TextStyle cancelButtonStyle =  TextStyle(
  color: Colors.redAccent, 
  fontFamily: 'Dosis', 
  fontSize: 16.0,
  fontWeight: FontWeight.w600
);
const TextStyle headTable =  TextStyle(
  color: fontColor, 
  fontFamily: 'Dosis', 
  fontSize: 15.0,
  fontWeight: FontWeight.w600
);
const TextStyle contentTable =  TextStyle(
  color: fontColorLight, 
  fontFamily: 'Dosis', 
  fontSize: 14.0,
  fontWeight: FontWeight.w500
);