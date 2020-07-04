import './../Models/accountType.model.dart';

class Controller {
  static Controller _instance;

  static Controller get instance {
    if (_instance == null) _instance = Controller();
    return _instance;
  }

  Future<List<AccountType>> _accTypes;

  Future<List<AccountType>> get accTypes {
    if (_accTypes == null) _accTypes = Model.instance.getAccTypes();
    return _accTypes;
  }

  Future<bool> insertAccType(String name) => Model.instance.insertAccType(name);

  Future<bool> updateAccType(int id, String name) =>
      Model.instance.updateAccType(id, name);

  Future<bool> deleteAccType(int id) => Model.instance.deleteAccType(id);

  Future<bool> isAccTypeExists(int id) => Model.instance.isAccTypeExists(id);

  Future<List<AccountType>> searchAccTypes(String keyword) async {
    List<AccountType> items = await accTypes;
    if (keyword.trim() == '') return items;
    return items
        .where((item) => item.name.toUpperCase().indexOf(keyword.toUpperCase()) != -1)
        .toList();
  }

  void insertAccTypeToLocal(String _name) async {
    int idMax = await Model.instance.getIDMax();
    AccountType accountType = AccountType(idMax, _name);
    (await accTypes).add(accountType);
  }

  void updateAccTypeToLocal(int _id, String _name) async {
    int index = await findIndex(_id);
    (await accTypes)[index].id = _id;
    (await accTypes)[index].name = _name;
  }

  void deleteAccTypeToLocal(int id) async {
    int index = await findIndex(id);
    (await accTypes).removeAt(index);
  }

  Future<int> findIndex(int id) async {
    for (var i = 0; i < (await accTypes).length; i++) {
      if ((await accTypes)[i].id == id) return i;
    }
    return -1;
  }
}
