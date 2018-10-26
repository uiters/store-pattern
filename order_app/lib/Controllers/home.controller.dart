// import 'package:mvc_pattern/mvc_pattern.dart';

import './../Models/home.model.dart';

class Controller {

  static Controller _instance;

  static Controller get instance {
    if (_instance == null) _instance = new Controller();
    return _instance;
  }

  Future<List<TableData>> get tables => Model.instance.tables;

}