import 'dart:io';

import 'package:image_picker/image_picker.dart';

import './../Models/account.model.dart';

class Controller {

  static Controller _instance;

  static Controller get instance {
    if (_instance == null) _instance = new Controller();
    return _instance;
  }

  Future<List<Account>> _accs;

  Future<List<Account>> get accs {
    if (_accs == null) _accs = Model.instance.getAccs();
    return _accs;
  }

  Future<bool> insertAcc(String username, String password, String displayname, int sex, String idCard, String address, String phoneNumber, DateTime birthday, int idAccountType, String image) {
    return Model.instance.insertAcc(username, password, displayname, sex, idCard, address, phoneNumber, birthday, idAccountType, image);
  }

  Future<bool> updateAcc(int id, String name) {
    return Model.instance.updateAcc(id, name);
  }

  void reloadAccs() {
    _accs = Model.instance.getAccs();
  }

  Future<List<Account>> searchAccs(String keyword) async {
    List<Account> items = await accs;
    if (keyword.trim() == '') return items;
    return items.where((item) => item.username.toUpperCase().indexOf(keyword.toUpperCase()) != -1).toList();
  }

  Future<File> getImage() async {
    return await ImagePicker.pickImage(source: ImageSource.gallery);
  }

}