import './../Models/cart.model.dart';

class Controller {

  static Controller _instance;

  static Controller get instance {
    if (_instance == null) _instance = new Controller();
    return _instance;
  }

  Future<bool> insertBill(int idTable, DateTime dateCheckIn, DateTime dateCheckOut, double discount, double totalPrice, int status) {
    return Model.instance.insertBill(idTable, dateCheckIn, dateCheckOut, discount, totalPrice, status);
  }

  Future<int> getIdBillMax() {
    return Model.instance.getIdBillMax();
  }

  Future<bool> insertBillDetail(int idBill, int idFood, int quantity) {
    return Model.instance.insertBillDetail(idBill, idFood, quantity);
  }
}