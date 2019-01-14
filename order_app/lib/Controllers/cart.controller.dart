import './../Models/cart.model.dart';

class Controller {
  bool isSend = false;

  static Controller _instance;

  static Controller get instance {
    if (_instance == null) _instance = new Controller();
    return _instance;
  }

  Future<bool> insertBill(int idTable, DateTime dateCheckIn, DateTime dateCheckOut, double discount, double totalPrice, int status, String username) {
    return Model.instance.insertBill(idTable, dateCheckIn, dateCheckOut, discount, totalPrice, status, username);
  }

  Future<bool> updateBill(int id, int idTable, DateTime dateCheckIn, DateTime dateCheckOut, double discount, double totalPrice, int status, String username) {
    return Model.instance.updateBill(id, idTable, dateCheckIn, dateCheckOut, discount, totalPrice, status, username);
  }

  Future<int> getIdBillMax() {
    return Model.instance.getIdBillMax();
  }

  Future<bool> hasBillOfTable(int idTable) {
    return Model.instance.hasBillOfTable(idTable);
  }

  Future<int> getIdBillByTable(int idTable) {
    return Model.instance.getIdBillByTable(idTable);
  }

  Future<bool> insertBillDetail(int idBill, int idFood, int quantity) {
    return Model.instance.insertBillDetail(idBill, idFood, quantity);
  }

  Future<bool> updateBillDetail(int idBill, int idFood, int quantity) {
    return Model.instance.updateBillDetail(idBill, idFood, quantity);
  }

  Future<bool> hasBillDetailOfBill(int idBill, int idFood) {
    return Model.instance.hasBillDetailOfBill(idBill, idFood);
  }
}