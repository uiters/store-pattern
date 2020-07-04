import './../Constants/queries.dart' as queries;
import 'connect_server.dart';

class Model {
  static Model _instance;

  static Model get instance {
    if (_instance == null) _instance = Model();
    return _instance;
  }

  Future<bool> insertBill(int idTable, DateTime dateCheckIn, DateTime dateCheckOut, double discount,
      double totalPrice, int status, String username) {
    return MySqlConnection.instance.executeNoneQuery(queries.INSERT_BILL,
        parameter: [idTable, dateCheckIn, dateCheckOut, discount, totalPrice, status, username]);
  }

  Future<bool> updateBill(int id, int idTable, DateTime dateCheckIn, DateTime dateCheckOut, double discount,
      double totalPrice, int status, String username) {
    return MySqlConnection.instance.executeNoneQuery(queries.UPDATE_BILL,
        parameter: [id, idTable, dateCheckIn, dateCheckOut, discount, totalPrice, status, username]);
  }

  Future<int> getIdBillMax() async {
    // check again
    Future<List> futureId = MySqlConnection.instance.executeQuery(queries.GET_ID_MAX);
    return parse(futureId);
  }

  Future<bool> hasBillOfTable(int idTable) async {
    Future<List> futureBills =
        MySqlConnection.instance.executeQuery(queries.HAS_BILL_OF_TABLE, parameter: [idTable]);
    return (await parseBill(futureBills)).isNotEmpty;
  }

  Future<int> getIdBillByTable(int idTable) async {
    Future<List> futureBills =
        MySqlConnection.instance.executeQuery(queries.HAS_BILL_OF_TABLE, parameter: [idTable]);
    return (await parseBill(futureBills))[0].id;
  }

  Future<bool> insertBillDetail(int idBill, int idFood, int quantity) {
    return MySqlConnection.instance
        .executeNoneQuery(queries.INSERT_BILL_DETAIL, parameter: [idBill, idFood, quantity]);
  }

  Future<bool> updateBillDetail(int idBill, int idFood, int quantity) {
    return MySqlConnection.instance
        .executeNoneQuery(queries.UPDATE_BILL_DETAIL, parameter: [idBill, idFood, quantity]);
  }

  Future<bool> hasBillDetailOfBill(int idBill, int idFood) async {
    Future<List> futureBillDetails =
        MySqlConnection.instance.executeQuery(queries.HAS_BILLDETAIL_OF_BILL, parameter: [idBill, idFood]);
    return (await parseBill(futureBillDetails)).isNotEmpty;
  }

  Future<int> parse(Future<List> id) async {
    int futureId = 0;
    await id.then((values) {
      futureId = Bill.fromJson(values[0]).id;
    });
    return futureId;
  }

  static Future<List<Bill>> parseBill(Future<List> futureBills) async {
    List<Bill> bills = [];
    await futureBills.then((values) {
      values.forEach((value) => bills.add(Bill.fromJson(value)));
    });
    return bills;
  }

  static Future<List<BillDetail>> parseBillDetail(Future<List> futureBillDetails) async {
    List<BillDetail> billDetails = [];
    await futureBillDetails.then((values) {
      values.forEach((value) => billDetails.add(BillDetail.fromJson(value)));
    });
    return billDetails;
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

class BillDetail {
  int idBill;
  int idFood;
  int quantity;

  BillDetail.fromJson(Map<String, dynamic> json) {
    this.idBill = json['IDBill'] != null ? int.parse(json['IDBill']) : -1;
    this.idFood = json['IDFood'] != null ? int.parse(json['IDFood']) : -1;
    this.quantity = json['Quantity'] != null ? int.parse(json['Quantity']) : -1;
  }
}
