import './../Models/bill.model.dart';

class Controller {

  static final Controller instance = new Controller();

  Future<List<Bill>> _bills;

  Future<List<Bill>> get bills {
    if (_bills == null) _bills = Model.instance.getBills();
    return _bills;
  }

  Future<bool> deleteBill(int id) {
    return Model.instance.deleteBill(id);
  }

  Future<List<Bill>> searchFoods(String keyword) async {
    List<Bill> items = await _bills;
    if (keyword.trim() == '') return items;
    return items.where((item) => item.nameTable.toUpperCase().indexOf(keyword.toUpperCase()) != -1).toList();
  }

  void deleteLocal(int id) async {
    int index = await findIndex(id);
    (await bills).removeAt(index);
  }

  Future<int> findIndex(int id) async {
    var bill = (await bills);
    for (var i = 0; i < bill.length; ++i) {
        if (bill[i].id == id) return i;
    }
    return -1;
  }
}