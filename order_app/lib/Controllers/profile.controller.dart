import 'package:dbcrypt/dbcrypt.dart';
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

  Future<bool> updatePassword(String username, String newPass) {
    return Model.instance.updatePassword(
      username, 
      new DBCrypt().hashpw(newPass, new DBCrypt().gensalt())
    );
  }

  bool equalPass(String hashPass, String passCheck) => DBCrypt().checkpw(passCheck, hashPass);

  String toHashPass(String pass) => new DBCrypt().hashpw(pass, new DBCrypt().gensalt());

}