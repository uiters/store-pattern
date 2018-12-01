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
  
  Future<List<AccountType>> getAccTypes() async {
    Future<List> futureAccTypes = MySqlConnection.instance.executeQuery(
      queries.GET_ACCTYPES
    );
    return parseAccType(futureAccTypes);
  }

  Future<bool> insertAccType(String name) {
    return MySqlConnection.instance.executeNoneQuery(
      queries.INSERT_ACCTYPE,
      parameter: [name]
    );
  }

  Future<bool> updateAccType(int id, String name) {
    return MySqlConnection.instance.executeNoneQuery(
      queries.UPDATE_ACCTYPE,
      parameter: [id, name]
    );
  }

  Future<List<AccountType>> parseAccType(Future<List> futureAccTypes) async  {
    List<AccountType> accTypes = [];
    await futureAccTypes.then((values) {
      values.forEach((value) => accTypes.add(new AccountType.fromJson(value)));
    });
    return accTypes;
  }
}

class AccountType {
  int id;
  String name;

  AccountType.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['ID']);
    name = json['Name'];
  }
}