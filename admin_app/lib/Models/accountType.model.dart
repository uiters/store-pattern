import './../Constants/queries.dart' as queries;
import './account.model.dart' as accModel;
import 'connect_server.dart';

class Model {
  static Model _instance;

  static Model get instance {
    if (_instance == null) {
      _instance = Model();
    }
    return _instance;
  }

  Future<List<AccountType>> getAccTypes() async {
    Future<List> futureAccTypes = MySqlConnection.instance.executeQuery(queries.GET_ACCTYPES);
    return parseAccType(futureAccTypes);
  }

  Future<bool> insertAccType(String name) {
    return MySqlConnection.instance.executeNoneQuery(queries.INSERT_ACCTYPE, parameter: [name]);
  }

  Future<bool> updateAccType(int id, String name) {
    return MySqlConnection.instance.executeNoneQuery(queries.UPDATE_ACCTYPE, parameter: [id, name]);
  }

  Future<bool> deleteAccType(int id) {
    return MySqlConnection.instance.executeNoneQuery(queries.DELETE_ACCTYPE, parameter: [id]);
  }

  Future<bool> isAccTypeExists(int id) async {
    // check food exists on bill
    Future<List> futureAccs =
        MySqlConnection.instance.executeQuery(queries.IS_ACCTYPE_EXISTS, parameter: [id]);
    return (await accModel.Model.parseAcc(futureAccs)).isNotEmpty;
  }

  Future<int> getIDMax() async {
    Future<List> futureAccTypes = MySqlConnection.instance.executeQuery(queries.GET_ID_ACCTYPE_MAX);
    return (await parseAccType(futureAccTypes))[0].id;
  }

  Future<List<AccountType>> parseAccType(Future<List> futureAccTypes) async {
    List<AccountType> accTypes = [];
    await futureAccTypes.then((values) {
      values.forEach((value) => accTypes.add(AccountType.fromJson(value)));
    });
    return accTypes;
  }
}

class AccountType {
  int id;
  String name;

  AccountType(int _id, String _name) {
    id = _id;
    name = _name;
  }

  AccountType.fromJson(Map<String, dynamic> json) {
    id = json['ID'] != null ? int.parse(json['ID']) : -1;
    name = json['Name'] ?? '';
  }
}
