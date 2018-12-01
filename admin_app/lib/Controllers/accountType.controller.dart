import './../Models/accountType.model.dart';

class Controller {

  static Controller _instance;

  static Controller get instance {
    if (_instance == null) _instance = new Controller();
    return _instance;
  }

  Future<List<AccountType>> _accTypes;

  Future<List<AccountType>> get accTypes {
    if (_accTypes == null) _accTypes = Model.instance.getAccTypes();
    return _accTypes;
  }

  Future<bool> insertAccType(String name) {
    return Model.instance.insertAccType(name);
  }

  Future<bool> updateAccType(int id, String name) {
    return Model.instance.updateAccType(id, name);
  }

  void reloadAccTypes() {
    _accTypes = Model.instance.getAccTypes();
  }

  Future<List<AccountType>> searchAccTypes(String keyword) async {
    List<AccountType> items = await accTypes;
    if (keyword.trim() == '') return items;
    return items.where((item) => item.name.toUpperCase().indexOf(keyword.toUpperCase()) != -1).toList();
  }

}