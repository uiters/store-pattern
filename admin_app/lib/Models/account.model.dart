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

  Future<bool> insertAcc(String username, String password, String displayname, int sex, String idCard, String address, String phoneNumber, DateTime birthday, int idAccountType, String image) {
    return MySqlConnection.instance.executeNoneQuery(
      queries.INSERT_ACC,
      parameter: [username, password, displayname, sex, idCard, address, phoneNumber, birthday, idAccountType, image]
    );
  }

  Future<bool> updateAcc(String username, String displayname, int sex, String idCard, String address, String phoneNumber, DateTime birthday, int idAccountType, String image) {
    return MySqlConnection.instance.executeNoneQuery(
      queries.UPDATE_ACC,
      parameter: [username, displayname, sex, idCard, address, phoneNumber, birthday, idAccountType, image]
    );
  }

  Future<bool> resetAcc(String username, String defaultPass) {
    return MySqlConnection.instance.executeNoneQuery(
      queries.RESET_ACC,
      parameter: [username, defaultPass]
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
  int idAccountType;
  Uint8List image;
  int idImange;

  Account(String username, String displayname, int sex, String idCard, String address, String phoneNumber, DateTime birthday, int idAccountType, Uint8List image) {
    this.username = username;
    this.displayName = displayname;
    this.sex = sex;
    this.idCard = idCard;
    this.address = address;
    this.phone = phoneNumber;
    this.birthday = birthday;
    this.idAccountType = idAccountType;
    this.image = image;
  }

  Account.fromJson(Map<String, dynamic> json) {
    username = json['Username'];
    displayName = json['DisplayName'] != null ? json['DisplayName'] : '';
    password = json['Password'];
    sex = json['Sex'] != null ? int.parse(json['Sex']) : -1;
    idCard = json['IDCard'] != null ? json['IDCard'] : '';
    address = json['Address'] != null ? json['Address'] : '';
    phone = json['PhoneNumber'] != null ? json['PhoneNumber'] : '';
    birthday = json['BirthDay'] != null ? DateTime.parse(json['BirthDay']) : DateTime.now().subtract(new Duration(days: 365 * 18));
    accountType = json['Name'] != null ? json['Name'] : '';
    idAccountType = int.parse(json['IDAccountType']);
    image = json['Data'] != null ? base64.decode(json['Data']) : null;
    idImange = int.parse(json['IDImage']);
  }

}