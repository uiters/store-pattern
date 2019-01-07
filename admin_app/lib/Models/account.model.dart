import 'dart:convert';
import 'dart:typed_data';

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
  
  Future<List<Account>> getAccs() async {
    Future<List> futureAccs = MySqlConnection.instance.executeQuery(
      queries.GET_ACCS
    );
    return parseAcc(futureAccs);
  }

  Future<bool> insertAcc(String name) {
    return MySqlConnection.instance.executeNoneQuery(
      queries.INSERT_ACC,
      parameter: [name]
    );
  }

  Future<bool> updateAcc(int id, String name) {
    return MySqlConnection.instance.executeNoneQuery(
      queries.UPDATE_ACC,
      parameter: [id, name]
    );
  }

  Future<List<Account>> parseAcc(Future<List> futureAccs) async  {
    List<Account> accs = [];
    await futureAccs.then((values) {
      values.forEach((value) => accs.add(new Account.fromJson(value)));
    });
    return accs;
  }
}

class Account {
   String username;
  String displayName;
  String password;
  int sex;
  String idCard;
  String address;
  String phone;
  DateTime birthday;
  String accountType;
  Uint8List image;
  int idImange;

  Account.fromJson(Map<String, dynamic> json) {
    username = json['Username'];
    displayName = json['DisplayName'];
    password = json['Password'];
    sex = int.parse(json['Sex']);
    idCard = json['IDCard'];
    address = json['Address'];
    phone = json['PhoneNumber'];
    birthday = DateTime.parse(json['BirthDay']);
    accountType = json['Name'] != null ? json['Name'] : '';
    image = json['Data'] != null ? base64.decode(json['Data']) : null;
    this.idImange = int.parse(json['IDImage']);
  }

}