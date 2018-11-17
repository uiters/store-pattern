import 'package:dbcrypt/dbcrypt.dart';

import './../Models/login.model.dart';

class Controller {

  static Controller _instance;

  Account account;

  static Controller get instance {
    if (_instance == null) _instance = new Controller();
    return _instance;
  }

  Future<bool> login(String username, String password) async {
    if (account == null)
      account = await Model.instance.login(username);
    return account != null ? DBCrypt().checkpw(password, account.password) : false;
  }

}