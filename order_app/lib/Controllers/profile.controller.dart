import './../Models/profile.model.dart';

class Controller {

  static Controller _instance;

  static Controller get instance {
    if (_instance == null) _instance = new Controller();
    return _instance;
  }

  Future<bool> updateInfo(String username, String displayName, int sex, DateTime birthday, String idCard, String address, String phone) {
    return Model.instance.updateInfo(username, displayName, sex, birthday, idCard, address, phone);
  }

}