import './../Models/bill.model.dart';

class Controller {
  static final Controller instance = Controller();

  Future<List<Bill>> _bills;

  Future<List<Bill>> get bills {
    _bills = Model.instance.getBills();
    return _bills;
  }

  Future<bool> deleteBill(int id) {
    return Model.instance.deleteBill(id);
  }

  Future<List<Food>> getFoodByBill(int idBill) => Model.instance.getFoodByBill(idBill);

  Future<List<Bill>> searchFoods(
      String keyword, DateTime dateStart, DateTime dateEnd) async {
    if (_bills == null) return null;
    List<Bill> items = await _bills;
    if (keyword.trim() == '') return items;
    return items
        .where((item) =>
            item.nameTable.toUpperCase().indexOf(keyword.toUpperCase()) != -1 &&
            ((item.dateCheckIn.compareTo(dateStart) >= 0 &&
                    item.dateCheckIn.compareTo(dateEnd) <= 0) ||
                (item.dateCheckOut.compareTo(dateStart) >= 0 &&
                    item.dateCheckOut.compareTo(dateEnd) <= 0)))
        .toList();
  }

  void deleteLocal(int id) async {
    int index = await findIndex(id);
    if (index == -1) return;
    (await _bills).removeAt(index);
  }

  Future<int> findIndex(int id) async {
    var bill = (await _bills);
    for (var i = 0; i < bill.length; ++i) {
      if (bill[i].id == id) return i;
    }
    return -1;
  }
}
