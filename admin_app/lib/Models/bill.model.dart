import 'dart:typed_data';

import './../Constants/queries.dart' as queries;
import 'connect_server.dart';

class Model {
  static final Model instance = Model();

  Future<List<Bill>> getBills() async {
    Future<List> futureFoods = MySqlConnection.instance.executeQuery(queries.QUERY_GET_BILLS);
    return parseBill(futureFoods);
  }

  Future<bool> deleteBill(int id) {
    return MySqlConnection.instance.executeNoneQuery(queries.QUERY_DELETE_BILLS, parameter: [id]);
  }

  Future<List<Food>> getFoodByBill(int idBill) async {
    Future<List> futureFoods =
        MySqlConnection.instance.executeQuery(queries.GET_BILLDETAIL_BY_BILL, parameter: [idBill]);
    return parseFood(futureFoods);
  }

  Future<List<Bill>> parseBill(Future<List> futureBills) async {
    List<Bill> bills = [];
    await futureBills.then((values) {
      values.forEach((value) => bills.add(Bill.fromJson(value)));
    });
    return bills;
  }

  static Future<List<Food>> parseFood(Future<List> foods) async {
    List<Food> futureFoods = [];
    await foods.then((values) {
      values.forEach((value) {
        futureFoods.add(Food.fromJson(value));
      });
    });
    return futureFoods;
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
    this.nameTable = json['Name'] ?? '';
    this.dateCheckIn = DateTime.parse(json['DateCheckIn']);
    this.dateCheckOut = DateTime.parse(json['DateCheckOut']);
    this.discount = double.parse(json['Discount']);
    this.totalPrice = double.parse(json['TotalPrice']);
    this.status = int.parse(json['Status']) > 0 ? 'Paid' : 'Unpaid';
    this.userName = json['Username'];
  }
}

class Food {
  int id;
  String name;
  int idFoodCategory;
  double price;
  int quantity;
  int idImange;
  Uint8List image;

  Food(Food _food) {
    this.id = _food.id;
    this.name = _food.name;
    this.idFoodCategory = _food.idFoodCategory;
    this.price = _food.price;
    this.quantity = _food.quantity;
    this.image = _food.image;
  }

  Food.fromJson(Map<String, dynamic> json) {
    this.id = int.parse(json['ID']);
    this.name = json['Name'];
    this.idFoodCategory = int.parse(json['IDCategory']);
    this.price = double.parse(json['Price']);
    this.quantity = json['Quantity'] != null ? int.parse(json['Quantity']) : 0;
    //this.image = json['Image'] != null ? base64.decode(json['Image']) : null;
    this.idImange = int.parse(json['IDImage']);
    //this.image = base64.decode(json['Image']);
  }
}
