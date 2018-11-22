import './connectServer.dart';

import './../Constants/queries.dart' as queries;

class Model {

  static Model _instance;

  static Model get instance {
    if (_instance == null) {
      _instance = new Model();
    }
    return _instance;
  }

  Future<bool> updateInfo(String username, String displayName, int sex, DateTime birthday, String idCard, String address, String phone) {
    return MySqlConnection.instance.executeNoneQuery(
      queries.UPDATE_ACC_INFO,
      parameter: [username, displayName, sex, birthday, idCard, address, phone]
    );
  }
  
}