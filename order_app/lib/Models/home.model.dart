import 'dart:convert';

import './connectServer.dart';

class Model {

  static Model _instance;

  static Model get instance {
    if (_instance == null) _instance = new Model();
    getTables();
    return _instance;
  }

  Future<List<TableData>> get tables => getTables();

  static Future<List<TableData>> getTables() async {
    String query = 'CALL `USP_GetTables`();';
    Future<List> futureTables = MySqlConnection.instance.executeQuery(query);
    return parse(futureTables);//(futureTables as List).map((json) => TableData.fromJson(json)).toList();
  }

  static Future<List<TableData>> parse(Future<List> tables) async  {

    List<TableData> tableDatas = [];
    await tables.then((values){
      values.forEach((f){
        tableDatas.add(TableData.fromJson(f));
      });
    });
    return tableDatas;
  }

  static List<TableData> parseTables(dynamic responseString) {    
    final parsed = json.decode(responseString).cast<Map<String, dynamic>>();

    return parsed.map<TableData>((json) => TableData.fromJson(json)).toList();
  }

}

class TableData {
  int id;
  String name;
  int status;

  TableData({this.id, this.name, this.status});

  TableData.fromJson(Map<String, dynamic> json)
  : this.id = int.parse(json['ID']),
    this.name = json['Name'],
    this.status = int.parse(json['Status']);
}