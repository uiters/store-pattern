import './connectServer.dart';
import './../Constants/queries.dart' as queries;

class Model {

  static Model _instance;

  static Model get instance {
    if (_instance == null) _instance = new Model();
    return _instance;
  }

  Future<bool> insertBill(int idTable, DateTime dateCheckIn, DateTime dateCheckOut, double discount, double totalPrice, int status) {
    return MySqlConnection.instance.executeNoneQuery(
      queries.INSERT_BILL, 
      parameter: [idTable, dateCheckIn, dateCheckOut, discount, totalPrice, status]
    ); 
  }

  Future<int> getIdBillMax() async { // check again
    Future<List> futureId = MySqlConnection.instance.executeQuery(queries.GET_ID_MAX);
    return parse(futureId);
  }

  Future<int> parse(Future<List> id) async  {
    int futureId = 0;
    await id.then((values){
      futureId = new Bill.fromJson(values[0]).id;
    });
    return futureId;
  }

  Future<bool> insertBillDetail(int idBill, int idFood, int quantity) {
    return MySqlConnection.instance.executeNoneQuery(
      queries.INSERT_BILL_DETAIL,
      parameter: [idBill, idFood, quantity]
    );
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
    this.id = int.parse(json['ID']);
    this.idTable = json['IDTable'] != null ? int.parse(json['IDTable']) : -1;
    this.dateCheckIn = json['DateCheckIn'] != null ? DateTime.parse(json['DateCheckIn']) :DateTime.now();
    this.dateCheckOut = json['DateCheckOut'] != null ? DateTime.parse(json['DateCheckOut']) : DateTime.now();
    this.status = json['Status'] !=null ? int.parse(json['Status']) : -1;
  }

}

class BillDetail {

  int idBill;
  int idFood;
  int quantity;

  BillDetail.fromJson(Map<String, dynamic> json) {
    this.idBill = int.parse(json['IDBill']);
    this.idFood = int.parse(json['IDFood']);
    this.quantity = int.parse(json['Quantity']);
  }

}