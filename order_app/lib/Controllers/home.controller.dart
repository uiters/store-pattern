import 'package:mvc_pattern/mvc_pattern.dart';

import './../Models/home.model.dart';

class Controller extends ControllerMVC {

  static List<int> get tableNumbers => Model.tableNumbers;

  static void generateNumbers() => Model.generateNumbers();
  
}