import 'dart:convert';
import 'dart:typed_data';

import './../Constants/queries.dart' as queries;
import 'connect_server.dart';

class Model {
  static Model _instance;

  static Model get instance {
    if (_instance == null) {
      _instance = Model();
    }
    return _instance;
  }

  Future<List<Account>> getAccounts() async {
    Future<List> futureAccounts = MySqlConnection.instance.executeQuery(queries.GET_ACCS);
    return parseAcc(futureAccounts);
  }

  Future<bool> insertAcc(String username, String password, String displayname, int sex, String idCard,
      String address, String phoneNumber, DateTime birthday, int idAccountType, String image) {
    return MySqlConnection.instance.executeNoneQuery(queries.INSERT_ACC, parameter: [
      username,
      password,
      displayname,
      sex,
      idCard,
      address,
      phoneNumber,
      birthday,
      idAccountType,
      image
    ]);
  }

  Future<bool> updateAcc(String username, String displayname, int sex, String idCard, String address,
      String phoneNumber, DateTime birthday, int idAccountType, String image) {
    return MySqlConnection.instance.executeNoneQuery(queries.UPDATE_ACC, parameter: [
      username,
      displayname,
      sex,
      idCard,
      address,
      phoneNumber,
      birthday,
      idAccountType,
      image
    ]);
  }

  Future<bool> deleteAcc(String username) {
    return MySqlConnection.instance.executeNoneQuery(queries.DELETE_ACC, parameter: [username]);
  }

  Future<bool> isAccExists(String username) async {
    Future<List> futureBills =
        MySqlConnection.instance.executeQuery(queries.IS_ACC_EXISTS, parameter: [username]);
    return (await parseBill(futureBills)).isNotEmpty;
  }

  Future<bool> resetAcc(String username, String defaultPass) {
    return MySqlConnection.instance.executeNoneQuery(queries.RESET_ACC, parameter: [username, defaultPass]);
  }

  static Future<List<Account>> parseAcc(Future<List> futureAccs) async {
    List<Account> accs = [];
    await futureAccs.then((values) {
      values.forEach((value) => accs.add(Account.fromJson(value)));
    });
    return accs;
  }

  Future<List<Bill>> parseBill(Future<List> futureBills) async {
    List<Bill> bills = [];
    await futureBills.then((values) {
      values.forEach((value) => bills.add(Bill.fromJson(value)));
    });
    return bills;
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

  Account(String username, String displayname, int sex, String idCard, String address, String phoneNumber,
      DateTime birthday, int idAccountType, Uint8List image) {
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
    displayName = json['DisplayName'] ?? '';
    password = json['Password'];
    sex = json['Sex'] != null ? int.parse(json['Sex']) : -1;
    idCard = json['IDCard'] ?? '';
    address = json['Address'] ?? '';
    phone = json['PhoneNumber'] ?? '';
    birthday = json['BirthDay'] != null
        ? DateTime.parse(json['BirthDay'])
        : DateTime.now().subtract(Duration(days: 365 * 18));
    accountType = json['Name'] ?? '';
    idAccountType = int.parse(json['IDAccountType']);
    image = json['Data'] != null ? base64.decode(json['Data']) : null;
    idImange = int.parse(json['IDImage']);
  }
}

class Bill {
  int id;
  int idTable;
  DateTime dateCheckIn;
  DateTime dateCheckOut;
  double discount;
  double totalPrice;
  int status;

  Bill.fromJson(Map<String, dynamic> json) {
    this.id = json['ID'] != null ? int.parse(json['ID']) : -1;
    this.idTable = json['IDTable'] != null ? int.parse(json['IDTable']) : -1;
    this.dateCheckIn = json['DateCheckIn'] != null ? DateTime.parse(json['DateCheckIn']) : DateTime.now();
    this.dateCheckOut = json['DateCheckOut'] != null ? DateTime.parse(json['DateCheckOut']) : DateTime.now();
    this.status = json['Status'] != null ? int.parse(json['Status']) : -1;
  }
}
