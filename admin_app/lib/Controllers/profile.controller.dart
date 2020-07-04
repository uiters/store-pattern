import 'package:dbcrypt/dbcrypt.dart';

import './../Models/profile.model.dart';

class Controller {
  static Controller _instance;

  static Controller get instance {
    if (_instance == null) _instance = Controller();
    return _instance;
  }

  bool equalPass(String hashPass, String passCheck) =>
      DBCrypt().checkpw(passCheck, hashPass);

  String toHashPass(String pass) => DBCrypt().hashpw(pass, DBCrypt().gensalt());

  Future<bool> updateAvatar(String username, String image) {
    return Model.instance.updateAvatar(username, image);
  }

  Future<bool> updateInfo(String username, String displayName, int sex, DateTime birthday,
      String idCard, String address, String phone) {
    return Model.instance
        .updateInfo(username, displayName, sex, birthday, idCard, address, phone);
  }

  Future<bool> updatePassword(String username, String newPass) {
    return Model.instance
        .updatePassword(username, DBCrypt().hashpw(newPass, DBCrypt().gensalt()));
  }
}
