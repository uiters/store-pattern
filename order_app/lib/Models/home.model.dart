import './connectServer.dart';
import './../Constants/queries.dart';

class Model {

  static Model _instance;

  static Model get instance {
    if (_instance == null) _instance = new Model();
    getTables();
    return _instance;
  }

  Future<List<Table>> get tables => getTables();

  static Future<List<Table>> getTables() async {
    Future<List> futureTables = MySqlConnection.instance.executeQuery(QUERY_GET_TABLES);
    return parse(futureTables);
  }

  static Future<List<Table>> parse(Future<List> tables) async  {

    List<Table> futureTables = [];
    await tables.then((values){
      values.forEach((value){
        futureTables.add(Table.fromJson(value));
      });
    });
    return futureTables;

  }

}

class Table {
  int id;
  String name;
  int status;


  Table({this.id, this.name, this.status});

  Table.fromJson(Map<String, dynamic> json)
  : this.id = int.parse(json['ID']),
    this.name = json['Name'],
    this.status = int.parse(json['Status']);
}