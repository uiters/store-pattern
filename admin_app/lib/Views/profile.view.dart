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

  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _displayNameController = new TextEditingController();
  TextEditingController _idCardController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _accountTypeController = new TextEditingController();
  TextEditingController _birthDayController = new TextEditingController();
  TextEditingController _newPassController = new TextEditingController();
  TextEditingController _newPassConfirmController = new TextEditingController();
  TextEditingController _oldPassController = new TextEditingController();

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

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('app_icon');
    var ios = new IOSInitializationSettings();
    var initSetting = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(initSetting);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _itemStyle = new TextStyle(
        color: theme.fontColor,
        fontFamily: 'Dosis',
        fontSize: 16.0,
        fontWeight: FontWeight.w500);

    TextStyle _itemStyle2 = new TextStyle(
        color: theme.accentColor,
        fontFamily: 'Dosis',
        fontSize: 18.0,
        fontWeight: FontWeight.w500);

    Widget avatar = new Column(
      children: <Widget>[
        new Container(
            width: 100.0,
            height: 100.0,
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: _image == null
                      ? (widget.account.image.isEmpty
                          ? new AssetImage(
                              'assets/images/account.png',
                            )
                          : new MemoryImage(
                              widget.account.image,
                            ))
                      : new FileImage(
                          _image,
                        ),
                ))),
        new Container(
          height: 15.0,
        ),
        new RaisedButton(
          color: Colors.lightBlueAccent,
          child: new Text(
            'Select Image',
            style: _itemStyle,
          ),
          onPressed: () async {
            var image = await ImageController.getImageFromGallery();
            setState(() {
              _image = image;
            });
            if (_image != null) {
              if (await Controller.instance.updateAvatar(
                  widget.account.username, base64Encode(_image.readAsBytesSync()))) {
                successDialog(context, 'Upload avatar successfully!');

                setState(() {
                  widget.account.image = _image.readAsBytesSync();
                  loginController.Controller.instance.account.image =
                      _image.readAsBytesSync();
                });
              } else
                errorDialog(context, 'Upload avatar failed!');
            } else
              errorDialog(context, 'Image is null.\nPlease try again!');
          },
        )
      ],
    );

    Widget username = new TextField(
      enabled: false,
      controller: _usernameController,
      style: _itemStyle,
      decoration: new InputDecoration(labelText: 'Username:', labelStyle: _itemStyle2),
    );

    Widget displayName = new TextField(
      controller: _displayNameController,
      style: _itemStyle,
      decoration:
          new InputDecoration(labelText: 'Display name:', labelStyle: _itemStyle2),
    );

    Widget idCard = new TextField(
      controller: _idCardController,
      style: _itemStyle,
      decoration: new InputDecoration(labelText: 'Id card:', labelStyle: _itemStyle2),
    );

    Widget address = new TextField(
      controller: _addressController,
      style: _itemStyle,
      decoration: new InputDecoration(labelText: 'Address:', labelStyle: _itemStyle2),
    );

    Widget phone = new TextField(
      controller: _phoneController,
      style: _itemStyle,
      decoration: new InputDecoration(labelText: 'Phone:', labelStyle: _itemStyle2),
    );

    Widget accountType = new TextField(
      controller: _accountTypeController,
      style: _itemStyle,
      decoration: new InputDecoration(
          enabled: false, labelText: 'Account Type:', labelStyle: _itemStyle2),
    );

    Widget sex = new Row(
      children: <Widget>[
        new Text(
          'Sex:  ',
          style: new TextStyle(
              color: theme.accentColor,
              fontFamily: 'Dosis',
              fontSize: 13.0,
              fontWeight: FontWeight.w500),
        ),
        _buildSex(_itemStyle),
      ],
    );

    Widget birthDay = new Row(
      children: <Widget>[
        Flexible(
          child: new TextField(
            controller: _birthDayController,
            style: _itemStyle,
            decoration: new InputDecoration(
                enabled: false, labelText: 'Birthday:', labelStyle: _itemStyle2),
          ),
        ),
        new RaisedButton(
          child: new Text(
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
        child: new RaisedButton(
          color: Colors.redAccent,
          child: new Text(
            'Save Change',
            style: _itemStyle,
          ),
          onPressed: () {
            _changeInfo();
          },
        ),
      ),
    );

    Widget oldPass = new TextField(
      controller: _oldPassController,
      obscureText: true,
      style: _itemStyle,
      decoration:
          new InputDecoration(labelText: 'Old password:', labelStyle: _itemStyle2),
    );

    Widget newPass = new TextField(
      obscureText: true,
      controller: _newPassController,
      style: _itemStyle,
      decoration:
          new InputDecoration(labelText: 'New password:', labelStyle: _itemStyle2),
    );

    Widget newPassConfirm = new TextField(
      obscureText: true,
      controller: _newPassConfirmController,
      style: _itemStyle,
      decoration: new InputDecoration(
          labelText: 'Confirm new password:', labelStyle: _itemStyle2),
    );

    Widget changePass = Container(
      margin: const EdgeInsets.only(top: 15.0),
      child: SizedBox(
        width: double.infinity,
        child: new RaisedButton(
          color: Colors.redAccent,
          child: new Text(
            'Change Password',
            style: _itemStyle,
          ),
          onPressed: () {
            if (Controller.instance
                .equalPass(widget.account.password, _oldPassController.text))
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
      child: new ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
        scrollDirection: Axis.vertical,
        children: <Widget>[
          avatar,
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: new Card(
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
            child: new Card(
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
            title: new Text('Confirm', style: theme.titleStyle),
            content: new Text('Do you want to change infomations for this account?',
                style: theme.contentStyle),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Ok', style: theme.okButtonStyle),
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

                    login.Account account = widget.account;
                    account.displayName = _displayNameController.text;
                    account.sex = _sex == 'Male' ? 1 : (_sex == 'Female' ? 0 : -1);
                    account.birthday = DateTime.parse(_birthDayController.text);
                    account.idCard = _idCardController.text;
                    account.address = _addressController.text;
                    account.phone = _phoneController.text;
                  } else
                    errorDialog(this.context,
                        'Change information failed.' + '\nPlease try again!');
                },
              ),
              new FlatButton(
                child: new Text('Cancel', style: theme.cancelButtonStyle),
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
            title: new Text('Confirm', style: theme.titleStyle),
            content: new Text('Do you want to change password for this account?',
                style: theme.contentStyle),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Ok', style: theme.okButtonStyle),
                onPressed: () async {
                  /* Pop screens */
                  Navigator.of(context).pop();

                  if (_newPassConfirmController.text == _newPassController.text &&
                      _newPassController.text == '') {
                    errorDialog(
                        this.context, 'Invalid new password.' + '\nPlease try again!');
                    return;
                  }

                  if (_newPassConfirmController.text == _newPassController.text) {
                    // Check updatePassword
                    if (await Controller.instance.updatePassword(
                        widget.account.username, _newPassController.text)) {
                      login.Account account = widget.account;
                      account.password =
                          Controller.instance.toHashPass(_newPassController.text);
                      successDialog(this.context, 'Change password success!');
                    } else
                      errorDialog(this.context,
                          'Change password failed.' + '\nPlease try again!');
                  } else
                    errorDialog(
                        this.context,
                        'New password does not match the confirm password.' +
                            '\nPlease try again!');

                  _oldPassController.clear();
                  _newPassConfirmController.clear();
                  _newPassController.clear();
                },
              ),
              new FlatButton(
                child: new Text('Cancel', style: theme.cancelButtonStyle),
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
        firstDate: new DateTime(1975),
        lastDate: new DateTime(2019));
    if (picked != null)
      setState(() => _birthDayController.text = picked.toString().split(' ')[0]);
  }

  Widget _buildSex(TextStyle _itemStyle) {
    List<DropdownMenuItem> items = [];
    List<String> listSex = ['Male', 'Female', 'Other'];
    for (int i = 0; i < listSex.length; i++) {
      DropdownMenuItem item = new DropdownMenuItem(
        value: listSex[i],
        child: new Text(
          listSex[i],
          style: _itemStyle,
        ),
      );

      items.add(item);
    }

    return new DropdownButton(
        value: _sex,
        items: items,
        onChanged: (value) {
          setState(() {
            _sex = value;
          });
        });
  }
}
