import './../Models/home.model.dart';

class Controller {

  static Controller _instance;

  static Controller get instance {
    if (_instance == null) _instance = new Controller();
    return _instance;
  }

  Future<List<Table>> _tables;

  Future<List<Table>> get tables {
    if (_tables == null) _tables = Model.instance.tables;
    return _tables;
  }

}