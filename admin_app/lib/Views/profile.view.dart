import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:order_app/Controllers/image.controller.dart';

import './../Constants/dialog.dart';
import './../Constants/theme.dart' as theme;
import './../Controllers/login.controller.dart' as loginController;
import './../Controllers/profile.controller.dart';
import './../Models/login.model.dart' as login;

class ProfileScreen extends StatefulWidget {
  ProfileScreen({key, this.account}) : super(key: key);

  final login.Account account;

  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _displayNameController = TextEditingController();
  TextEditingController _idCardController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _accountTypeController = TextEditingController();
  TextEditingController _birthDayController = TextEditingController();
  TextEditingController _newPassController = TextEditingController();
  TextEditingController _newPassConfirmController = TextEditingController();
  TextEditingController _oldPassController = TextEditingController();

  String _sex;

  File _image;

  @override
  void initState() {
    login.Account account = widget.account;

    _usernameController.text = account.username;
    _displayNameController.text = account.displayName;
    _idCardController.text = account.idCard;
    _addressController.text = account.address;
    _phoneController.text = account.phone;
    _accountTypeController.text = account.accountType;
    _sex = account.sex == 1 ? 'Male' : (account.sex == 0 ? 'Female' : 'Other');
    _birthDayController.text = account.birthday.toString().split(' ')[0];

    super.initState();

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('app_icon');
    var ios = IOSInitializationSettings();
    var initSetting = InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(initSetting);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _itemStyle =
        TextStyle(color: theme.fontColor, fontFamily: 'Dosis', fontSize: 16.0, fontWeight: FontWeight.w500);

    TextStyle _itemStyle2 =
        TextStyle(color: theme.accentColor, fontFamily: 'Dosis', fontSize: 18.0, fontWeight: FontWeight.w500);

    Widget avatar = Column(
      children: <Widget>[
        Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: _image == null
                      ? (widget.account.image.isEmpty
                          ? AssetImage(
                              'assets/images/account.png',
                            )
                          : MemoryImage(
                              widget.account.image,
                            ))
                      : FileImage(
                          _image,
                        ),
                ))),
        Container(
          height: 15.0,
        ),
        RaisedButton(
          color: Colors.lightBlueAccent,
          child: Text(
            'Select Image',
            style: _itemStyle,
          ),
          onPressed: () async {
            var image = await ImageController.getImageFromGallery();
            setState(() {
              _image = image;
            });
            if (_image != null) {
              if (await Controller.instance
                  .updateAvatar(widget.account.username, base64Encode(_image.readAsBytesSync()))) {
                successDialog(context, 'Upload avatar successfully!');

                setState(() {
                  widget.account.image = _image.readAsBytesSync();
                  loginController.Controller.instance.account.image = _image.readAsBytesSync();
                });
              } else
                errorDialog(context, 'Upload avatar failed!');
            } else
              errorDialog(context, 'Image is null.\nPlease try again!');
          },
        )
      ],
    );

    Widget username = TextField(
      enabled: false,
      controller: _usernameController,
      style: _itemStyle,
      decoration: InputDecoration(labelText: 'Username:', labelStyle: _itemStyle2),
    );

    Widget displayName = TextField(
      controller: _displayNameController,
      style: _itemStyle,
      decoration: InputDecoration(labelText: 'Display name:', labelStyle: _itemStyle2),
    );

    Widget idCard = TextField(
      controller: _idCardController,
      style: _itemStyle,
      decoration: InputDecoration(labelText: 'Id card:', labelStyle: _itemStyle2),
    );

    Widget address = TextField(
      controller: _addressController,
      style: _itemStyle,
      decoration: InputDecoration(labelText: 'Address:', labelStyle: _itemStyle2),
    );

    Widget phone = TextField(
      controller: _phoneController,
      style: _itemStyle,
      decoration: InputDecoration(labelText: 'Phone:', labelStyle: _itemStyle2),
    );

    Widget accountType = TextField(
      controller: _accountTypeController,
      style: _itemStyle,
      decoration: InputDecoration(enabled: false, labelText: 'Account Type:', labelStyle: _itemStyle2),
    );

    Widget sex = Row(
      children: <Widget>[
        Text(
          'Sex:  ',
          style: TextStyle(
              color: theme.accentColor, fontFamily: 'Dosis', fontSize: 13.0, fontWeight: FontWeight.w500),
        ),
        _buildSex(_itemStyle),
      ],
    );

    Widget birthDay = Row(
      children: <Widget>[
        Flexible(
          child: TextField(
            controller: _birthDayController,
            style: _itemStyle,
            decoration: InputDecoration(enabled: false, labelText: 'Birthday:', labelStyle: _itemStyle2),
          ),
        ),
        RaisedButton(
          child: Text(
            'Change birthday',
            style: _itemStyle,
          ),
          onPressed: () {
            _selectDate();
          },
        )
      ],
    );

    Widget saveChange = Container(
      margin: const EdgeInsets.only(top: 15.0),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          color: Colors.redAccent,
          child: Text(
            'Save Change',
            style: _itemStyle,
          ),
          onPressed: () {
            _changeInfo();
          },
        ),
      ),
    );

    Widget oldPass = TextField(
      controller: _oldPassController,
      obscureText: true,
      style: _itemStyle,
      decoration: InputDecoration(labelText: 'Old password:', labelStyle: _itemStyle2),
    );

    Widget newPass = TextField(
      obscureText: true,
      controller: _newPassController,
      style: _itemStyle,
      decoration: InputDecoration(labelText: ' password:', labelStyle: _itemStyle2),
    );

    Widget newPassConfirm = TextField(
      obscureText: true,
      controller: _newPassConfirmController,
      style: _itemStyle,
      decoration: InputDecoration(labelText: 'Confirm  password:', labelStyle: _itemStyle2),
    );

    Widget changePass = Container(
      margin: const EdgeInsets.only(top: 15.0),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          color: Colors.redAccent,
          child: Text(
            'Change Password',
            style: _itemStyle,
          ),
          onPressed: () {
            if (Controller.instance.equalPass(widget.account.password, _oldPassController.text))
              _changePass();
            else {
              _oldPassController.clear();
              errorDialog(context, 'Password incorrect.' + '\nPlease try again!');
            }
          },
        ),
      ),
    );

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
        scrollDirection: Axis.vertical,
        children: <Widget>[
          avatar,
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Card(
              color: theme.primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    username,
                    displayName,
                    sex,
                    birthDay,
                    idCard,
                    address,
                    phone,
                    accountType,
                    saveChange
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Card(
              color: theme.primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[oldPass, newPass, newPassConfirm, changePass],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _changeInfo() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm', style: theme.titleStyle),
            content: Text('Do you want to change infomations for this account?', style: theme.contentStyle),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok', style: theme.okButtonStyle),
                onPressed: () async {
                  /* Pop screens */
                  Navigator.of(context).pop();

                  if (await Controller.instance.updateInfo(
                      widget.account.username,
                      _displayNameController.text,
                      _sex == 'Male' ? 1 : (_sex == 'Female' ? 0 : -1),
                      DateTime.parse(_birthDayController.text),
                      _idCardController.text,
                      _addressController.text,
                      _phoneController.text)) {
                    successDialog(this.context, 'Change information success!');

                    widget.account
                      ..displayName = _displayNameController.text
                      ..sex = _sex == 'Male' ? 1 : (_sex == 'Female' ? 0 : -1)
                      ..birthday = DateTime.parse(_birthDayController.text)
                      ..idCard = _idCardController.text
                      ..address = _addressController.text
                      ..phone = _phoneController.text;
                  } else
                    errorDialog(this.context, 'Change information failed.' + '\nPlease try again!');
                },
              ),
              FlatButton(
                child: Text('Cancel', style: theme.cancelButtonStyle),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _changePass() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm', style: theme.titleStyle),
            content: Text('Do you want to change password for this account?', style: theme.contentStyle),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok', style: theme.okButtonStyle),
                onPressed: () async {
                  /* Pop screens */
                  Navigator.of(context).pop();

                  if (_newPassConfirmController.text == _newPassController.text &&
                      _newPassController.text == '') {
                    errorDialog(this.context, 'Invalid  password.' + '\nPlease try again!');
                    return;
                  }

                  if (_newPassConfirmController.text == _newPassController.text) {
                    // Check updatePassword
                    if (await Controller.instance
                        .updatePassword(widget.account.username, _newPassController.text)) {
                      widget.account.password = Controller.instance.toHashPass(_newPassController.text);
                      successDialog(this.context, 'Change password success!');
                    } else
                      errorDialog(this.context, 'Change password failed.' + '\nPlease try again!');
                  } else
                    errorDialog(this.context,
                        ' password does not match the confirm password.' + '\nPlease try again!');

                  _oldPassController.clear();
                  _newPassConfirmController.clear();
                  _newPassController.clear();
                },
              ),
              FlatButton(
                child: Text('Cancel', style: theme.cancelButtonStyle),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: widget.account.birthday,
        firstDate: DateTime(1975),
        lastDate: DateTime(2019));
    if (picked != null) setState(() => _birthDayController.text = picked.toString().split(' ')[0]);
  }

  Widget _buildSex(TextStyle _itemStyle) {
    List<DropdownMenuItem> items = [];
    List<String> listSex = ['Male', 'Female', 'Other'];
    for (int i = 0; i < listSex.length; i++) {
      DropdownMenuItem item = DropdownMenuItem(
        value: listSex[i],
        child: Text(
          listSex[i],
          style: _itemStyle,
        ),
      );

      items.add(item);
    }

    return DropdownButton(
        value: _sex,
        items: items,
        onChanged: (value) {
          setState(() {
            _sex = value;
          });
        });
  }
}
