import './../Models/history.model.dart';

class Controller {
  static Controller _instance;

  static Controller get instance {
    if (_instance == null) _instance = new Controller();
    return _instance;
  }

  Future<List<BillPlus>> _bills;

  Future<List<BillPlus>> get bills {
    if (_bills == null) _bills = Model.instance.getListBill();
    return _bills;
  }

}