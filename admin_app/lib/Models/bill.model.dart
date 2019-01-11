import './connectServer.dart';

import './../Constants/queries.dart' as queries;

class Model {

  static final Model instance = new Model();
  
  Future<List<Bill>> getBills() async {
    Future<List> futureFoods = MySqlConnection.instance.executeQuery(
      queries.QUERY_GET_BILLS
    );
    return parseBill(futureFoods);
  }

  Future<List<Bill>> parseBill(Future<List> futureFoods) async  {
    List<Bill> foods = [];
    await futureFoods.then((values) {
      values.forEach((value) => foods.add(new Bill.fromJson(value)));
    });
    return foods;
  }

  Future<bool> deleteBill(int id) {
    return MySqlConnection.instance.executeNoneQuery(
      queries.QUERY_DELETE_BILLS,
      parameter: [id]
    );
  }
}

class Bill {
  int id;
  int idTable;
  String nameTable;
  DateTime dateCheckIn;
  DateTime dateCheckOut;
  double discount;
  double totalPrice;
  String status;
  String userName;


  Bill.fromJson(Map<String, dynamic> json) {
    this.id = json['ID'] != null ? int.parse(json['ID']) : 0;
    this.idTable = json['IDTable'] != null ? int.parse(json['IDTable']) : 0;
    this.nameTable = json['NameTable'] != null ? json['NameTable'] : '';
    this.dateCheckIn = DateTime.parse(json['DateCheckIn']);
    this.dateCheckOut = DateTime.parse(json['DateCheckOut']);
    this.discount = double.parse(json['Discount']);
    this.totalPrice = double.parse(json['TotalPrice']);
    this.status = int.parse(json['Status']) > 0 ? 'Paid' : 'Unpaid';
    this.userName = json['Username'];
  }
}