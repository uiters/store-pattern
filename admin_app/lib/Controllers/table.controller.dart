import './../Models/table.model.dart';

class Controller {

  static Controller _instance;

  static Controller get instance {
    if (_instance == null) _instance = new Controller();
    return _instance;
  }

  Future<List<Table>> _tables;

  Future<List<Table>> get tables {
    if (_tables == null) _tables = Model.instance.getTables();
    return _tables;
  }

  Future<bool> insertTable(String name) {
    return Model.instance.insertTable(name);
  }

  Future<bool> updateTable(int id, String name) {
    return Model.instance.updateTable(id, name);
  }

  void reloadTables() {
    _tables = Model.instance.getTables();
  }

}