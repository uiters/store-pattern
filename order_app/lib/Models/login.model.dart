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

  Future<Account> login(String username) async {
    Future<List> futureAccount = MySqlConnection.instance.executeQuery(
      queries.LOGIN,
      parameter: [username]
    );
    return parseAccount(futureAccount);
  }

  Future<Account> parseAccount(Future<List> accounts) async  {
    Account account;
    await accounts.then((values){
      if (values.length > 0)
      account = Account.fromJson(values[0]);
    });
    return account;
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
    image = json['Data'] != null ? base64.decode(json['Data']) : null;
  }
}
