import './connectServer.dart';

import './../Constants/queries.dart' as queries;

class Model {

  static Model _instance;

  static Model get instance {
    if (_instance == null) {
      _instance = new Model();
    }
    return _instance;
  }
  
  Future<List<Table>> getTables() async {
    Future<List> futureTables = MySqlConnection.instance.executeQuery(
      queries.GET_TABLES
    );
    return parseTable(futureTables);
  }

  Future<bool> insertTable(String name) {
    return MySqlConnection.instance.executeNoneQuery(
      queries.INSERT_TABLE,
      parameter: [name]
    );
  }

  Future<bool> updateTable(int id, String name) {
    return MySqlConnection.instance.executeNoneQuery(
      queries.UPDATE_TABLE,
      parameter: [id, name, -1]
    );
  }

  Future<List<Table>> parseTable(Future<List> futureTables) async  {
    List<Table> tables = [];
    await futureTables.then((values) {
      values.forEach((value) => tables.add(new Table.fromJson(value)));
    });
    return tables;
  }
}

class Table {
  int id;
  String name;
  int status;

  Table.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['ID']);
    name = json['Name'];
    status = int.parse(json['Status']);
  }
}