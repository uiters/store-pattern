import './../Models/table.model.dart';

class Controller {
  static Controller _instance;

  static Controller get instance {
    if (_instance == null) _instance = Controller();
    return _instance;
  }

  Future<List<Table>> _tables;

  Future<List<Table>> get tables {
    if (_tables == null) _tables = Model.instance.getTables();
    return _tables;
  }

  Future<bool> insertTable(String name) => Model.instance.insertTable(name);

  Future<bool> updateTable(int id, String name) => Model.instance.updateTable(id, name);

  Future<bool> deleteTable(int id) => Model.instance.deleteTable(id);

  Future<bool> isTableExists(int id) => Model.instance.isTableExists(id);

  Future<List<Table>> searchTables(String keyword) async {
    List<Table> items = await tables;
    if (keyword.trim() == '') return items;
    return items.where((item) => item.name.toLowerCase().indexOf(keyword.toLowerCase()) != -1).toList();
  }

  void insertTableToLocal(String name, int status) async {
    int idMax = await Model.instance.getIDMax();
    Table table = Table(idMax, name, status);
    (await tables).add(table);
  }

  void updateTableToLocal(int id, String name, int status) async {
    int index = await findIndex(id);
    (await tables)[index].id = id;
    (await tables)[index].name = name;
    (await tables)[index].status = status;
  }

  void deleteTableToLocal(int id) async {
    int index = await findIndex(id);
    (await tables).removeAt(index);
  }

  Future<int> findIndex(int id) async {
    for (var i = 0; i < (await tables).length; i++) {
      if ((await tables)[i].id == id) return i;
    }
    return -1;
  }
}
