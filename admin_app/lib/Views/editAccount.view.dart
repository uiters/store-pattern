import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import './../Constants/dialog.dart';
import './../Constants/theme.dart' as theme;
import './../Controllers/account.controller.dart';
import './../Controllers/accountType.controller.dart' as accTypeController;
import './../Models/account.model.dart';
import './../Models/accountType.model.dart' as accType;

class EditAccountScreen extends StatefulWidget {
  EditAccountScreen({key, this.acc}) : super(key: key);

  final Account acc;

  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _displayNameController = new TextEditingController();
  TextEditingController _idCardController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _birthDayController = new TextEditingController();

  Future<List<accType.AccountType>> accTypes = accTypeController.Controller.instance.accTypes;
  accType.AccountType _accType;
  String _sex;
  File _image;

  @override
  void initState() {
    Account account = widget.acc;
    _accType = new accType.AccountType(account.idAccountType, account.accountType);
    _usernameController.text = account.username;
    _displayNameController.text = account.displayName;
    _idCardController.text = account.idCard;
    _addressController.text = account.address;
    _phoneController.text = account.phone;
    _sex = account.sex == 1 ? 'Male' : (account.sex == 0 ? 'Female' : 'Other');
    _birthDayController.text = account.birthday.toString().split(' ')[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _itemStyle = new TextStyle(
        color: theme.fontColor, fontFamily: 'Dosis', fontSize: 16.0, fontWeight: FontWeight.w500);

    TextStyle _itemStyle2 = new TextStyle(
        color: theme.accentColor, fontFamily: 'Dosis', fontSize: 18.0, fontWeight: FontWeight.w500);

    Widget avatar = new Column(
      children: <Widget>[
        _image == null
            ? (widget.acc.image.isEmpty
                ? new Image.asset(
                    'assets/images/account.png',
                    width: 122.0,
                    height: 122.0,
                    fit: BoxFit.fill,
                  )
                : new Image.memory(
                    widget.acc.image,
                    width: 122.0,
                    height: 122.0,
                    fit: BoxFit.fill,
                  ))
            : new Image.file(
                _image,
                width: 122.0,
                height: 122.0,
                fit: BoxFit.fill,
              ),
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
            var image = await Controller.instance.getImage();
            setState(() {
              _image = image;
            });
          },
        )
      ],
    );

    Widget username = new TextField(
      enabled: false,
      controller: _usernameController,
      style: _itemStyle,
      decoration: new InputDecoration(labelText: 'Username:*', labelStyle: _itemStyle2),
    );

    Widget displayName = new TextField(
      controller: _displayNameController,
      style: _itemStyle,
      decoration: new InputDecoration(labelText: 'Display name:', labelStyle: _itemStyle2),
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

    Widget accountType = new Row(
      children: <Widget>[
        new Text(
          'Account Type:  ',
          style: new TextStyle(
              color: theme.accentColor, fontFamily: 'Dosis', fontSize: 13.0, fontWeight: FontWeight.w500),
        ),
        FutureBuilder<List<accType.AccountType>>(
          future: accTypes,
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            if (snapshot.hasData) {
              return _buildAccTypes(_itemStyle, snapshot.data);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );

    Widget sex = new Row(
      children: <Widget>[
        new Text(
          'Sex:  ',
          style: new TextStyle(
              color: theme.accentColor, fontFamily: 'Dosis', fontSize: 13.0, fontWeight: FontWeight.w500),
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
            decoration: new InputDecoration(enabled: false, labelText: 'Birthday:', labelStyle: _itemStyle2),
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
            _updateAcc(widget.acc.username);
          },
        ),
      ),
    );

    return Container(
      child: new Container(
          padding: const EdgeInsets.all(10.0),
          child: new ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
            scrollDirection: Axis.vertical,
            children: <Widget>[
              avatar,
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
          )),
    );
  }

  void _updateAcc(String username) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Confirm', style: theme.titleStyle),
            content:
                new Text('Do you want to update this account: ' + username + '?', style: theme.contentStyle),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Ok', style: theme.okButtonStyle),
                onPressed: () async {
                  /* Pop screens */
                  Navigator.of(context).pop();
                  if (await Controller.instance.updateAcc(
                    _usernameController.text.trim(),
                    _displayNameController.text.trim(),
                    _sex == 'Male' ? 1 : (_sex == 'Female' ? 0 : -1),
                    _idCardController.text.trim(),
                    _addressController.text.trim(),
                    _phoneController.text.trim(),
                    _birthDayController.text != '' ? DateTime.parse(_birthDayController.text) : null,
                    _accType.id,
                    _image != null ? base64Encode(_image.readAsBytesSync()) : '',
                  )) {
                    // reload accounts
                    Controller.instance.updateAccountToLocal(
                      _usernameController.text.trim(),
                      _displayNameController.text.trim(),
                      _sex == 'Male' ? 1 : (_sex == 'Female' ? 0 : -1),
                      _idCardController.text.trim(),
                      _addressController.text.trim(),
                      _phoneController.text.trim(),
                      _birthDayController.text != '' ? DateTime.parse(_birthDayController.text) : null,
                      _accType.id,
                      _image != null ? base64Encode(_image.readAsBytesSync()) : '',
                    );

                    successDialog(this.context, 'Update this account: ' + username + ' success!');
                  } else
                    errorDialog(this.context,
                        'Update this account: ' + username + ' failed.' + '\nPlease try again!');
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
        initialDate: widget.acc.birthday,
        firstDate: new DateTime(1975),
        lastDate: new DateTime(2019));
    if (picked != null) setState(() => _birthDayController.text = picked.toString().split(' ')[0]);
  }

  Widget _buildAccTypes(TextStyle _itemStyle, List<accType.AccountType> accTypes) {
    List<DropdownMenuItem> items = [];
    for (int i = 0; i < accTypes.length; i++) {
      DropdownMenuItem item = new DropdownMenuItem(
        value: _accType.id == accTypes[i].id ? _accType : accTypes[i],
        child: new Text(
          accTypes[i].name,
          style: _itemStyle,
        ),
      );
      items.add(item);
    }

    return new DropdownButton(
        value: _accType,
        items: items,
        onChanged: (value) {
          setState(() {
            _accType = value;
          });
        });
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
