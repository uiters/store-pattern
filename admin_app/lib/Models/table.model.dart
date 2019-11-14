import './../Constants/queries.dart' as queries;
import './connectServer.dart';

class Model {
  static Model _instance;

  static Model get instance {
    if (_instance == null) {
      _instance = new Model();
    }
    return _instance;
  }

  Future<List<Table>> getTables() async {
    Future<List> futureTables = MySqlConnection.instance.executeQuery(queries.GET_TABLES);
    return parseTable(futureTables);
  }

  Future<bool> insertTable(String name) {
    return MySqlConnection.instance.executeNoneQuery(queries.INSERT_TABLE, parameter: [name]);
  }

  Future<bool> updateTable(int id, String name) {
    return MySqlConnection.instance.executeNoneQuery(queries.UPDATE_TABLE, parameter: [id, name, -1]);
  }

  Future<bool> deleteTable(int id) {
    return MySqlConnection.instance.executeNoneQuery(queries.DELETE_TABLE, parameter: [id]);
  }

  Future<bool> isTableExists(int id) async {
    // check table exists on bill
    Future<List> futureBills =
        MySqlConnection.instance.executeQuery(queries.IS_TABLE_EXISTS, parameter: [id]);
    return (await parseBill(futureBills)).length > 0;
  }

  Future<int> getIDMax() async {
    Future<List> futureFoods = MySqlConnection.instance.executeQuery(queries.GET_ID_TABLE_MAX);
    return (await parseTable(futureFoods))[0].id;
  }

  Future<List<Table>> parseTable(Future<List> futureTables) async {
    List<Table> tables = [];
    await futureTables.then((values) {
      values.forEach((value) => tables.add(new Table.fromJson(value)));
    });
    return tables;
  }

  Future<List<Bill>> parseBill(Future<List> futureBills) async {
    List<Bill> bills = [];
    await futureBills.then((values) {
      values.forEach((value) => bills.add(new Bill.fromJson(value)));
    });
    return bills;
  }
}

class Table {
  int id;
  String name;
  int status;

  Table(int _id, String _name, int _status) {
    id = _id;
    name = _name;
    status = _status;
  }

  Table.fromJson(Map<String, dynamic> json) {
    id = json['ID'] != null ? int.parse(json['ID']) : -1;
    name = json['Name'] != null ? json['Name'] : '';
    status = json['Status'] != null ? int.parse(json['Status']) : -1;
  }
}

class Bill {
  int id;
  int idTable;
  DateTime dateCheckIn;
  DateTime dateCheckOut;
  double discount;
  double totalPrice;
  int status;

  Bill.fromJson(Map<String, dynamic> json) {
    this.id = json['ID'] != null ? int.parse(json['ID']) : -1;
    this.idTable = json['IDTable'] != null ? int.parse(json['IDTable']) : -1;
    this.dateCheckIn = json['DateCheckIn'] != null ? DateTime.parse(json['DateCheckIn']) : DateTime.now();
    this.dateCheckOut = json['DateCheckOut'] != null ? DateTime.parse(json['DateCheckOut']) : DateTime.now();
    this.status = json['Status'] != null ? int.parse(json['Status']) : -1;
  }
}
