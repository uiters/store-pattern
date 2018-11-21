import 'package:flutter/material.dart';
import 'dart:async';

import './../Models/login.model.dart' as login;

import './../Constants/theme.dart' as theme;

class ProfileScreen extends StatefulWidget {
  ProfileScreen({key, this.account}) : super(key: key);

  final login.Account account;

  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _displayNameController = new TextEditingController();
  TextEditingController _idCardController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _accountTypeController = new TextEditingController();
  TextEditingController _sexController = new TextEditingController();
  TextEditingController _birthDayController = new TextEditingController();
  TextEditingController _newPassController = new TextEditingController();
  TextEditingController _newPassConfirmController = new TextEditingController();
  TextEditingController _oldPassController = new TextEditingController();

  String _displayName = '';
  String _idCard = '';
  String _address = '';
  String _phone = '';
  String _accountType = '';
  String _sex;
  String _birthDay;
  String _newPass = '';
  String _newPassConfirm = '';
  String _oldPass = '';

  @override
    void initState() {
      login.Account account = widget.account;

      _displayNameController.text = account.displayName;
      _idCardController.text = account.idCard;
      _addressController.text = account.address;
      _phoneController.text = account.phone;
      _accountTypeController.text = account.accountType;
      _sex = account.sex == 1 ? 'Male' : (account.sex == 0 ? 'Female' : 'Other');
      _birthDayController.text = account.birthday.toString().split(' ')[0];
      
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    TextStyle _itemStyle = new TextStyle(
      color: theme.fontColor, 
      fontFamily: 'Dosis', 
      fontSize: 16.0,
      fontWeight: FontWeight.w500
    );

    TextStyle _itemStyle2 = new TextStyle(
      color: theme.accentColor, 
      fontFamily: 'Dosis', 
      fontSize: 18.0,
      fontWeight: FontWeight.w500
    );

    Widget avatar = new Column(
      children: <Widget>[
        new Container(
          width: 100.0,
          height: 100.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
              fit: BoxFit.fill,
              image: new MemoryImage(
                widget.account.image,
              )
            )
          )
        ),
        new Text(
          widget.account.username,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(
            color: theme.accentColor,
            fontFamily: 'Dosis',
            fontSize: 20.0
          ),
        ),
      ],
    );

    Widget displayName = new TextField(
      controller: _displayNameController,
      style: _itemStyle,
      onChanged: (value) {
        _displayName = value;
      },
      decoration: new InputDecoration(
        labelText: 'Display name:',
        labelStyle: _itemStyle2
      ),
    );

    Widget idCard = new TextField(
      controller: _idCardController,
      style: _itemStyle,
      onChanged: (value) {
        _idCard = value;
      },
      decoration: new InputDecoration(
        labelText: 'Id card:',
        labelStyle: _itemStyle2
      ),
    );

    Widget address = new TextField(
      controller: _addressController,
      style: _itemStyle,
      onChanged: (value) {
        _address = value;
      },
      decoration: new InputDecoration(
        labelText: 'Address:',
        labelStyle: _itemStyle2
      ),
    );

    Widget phone = new TextField(
      controller: _phoneController,
      style: _itemStyle,
      onChanged: (value) {
        _phone = value;
      },
      decoration: new InputDecoration(
        labelText: 'Phone:',
        labelStyle: _itemStyle2
      ),
    );

    Widget accountType = new TextField(
      controller: _accountTypeController,
      style: _itemStyle,
      onChanged: (value) {
        _accountType = value;
      },
      decoration: new InputDecoration(
        labelText: 'Account Type:',
        labelStyle: _itemStyle2
      ),
    );

    Widget sex = new Row(
      children: <Widget>[
        new Text(
          'Sex:  ',
          style: new TextStyle(
            color: theme.accentColor, 
            fontFamily: 'Dosis', 
            fontSize: 13.0,
            fontWeight: FontWeight.w500
          ),
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
            onChanged: (value) {
              // _birthDay = value;
            },
            decoration: new InputDecoration(
              labelText: 'Birthday:',
              labelStyle: _itemStyle2
            ),
          ),
        ),
        new RaisedButton(
          child: new Text(
            'Change birthday',
            style: _itemStyle,
          ), onPressed: () {
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

        },
        ),
      ),
    );

    Widget oldPass = new TextField(
      controller: _oldPassController,
      obscureText: true,
      style: _itemStyle,
      onChanged: (value) {
        _oldPass = value;
      },
      decoration: new InputDecoration(
        labelText: 'Old password:',
        labelStyle: _itemStyle2
      ),
    );

    Widget newPass = new TextField(
      obscureText: true,
      controller: _newPassController,
      style: _itemStyle,
      onChanged: (value) {
        _newPass = value;
      },
      decoration: new InputDecoration(
        labelText: 'New password:',
        labelStyle: _itemStyle2
      ),
    );

    Widget newPassConfirm = new TextField(
      obscureText: true,
      controller: _newPassConfirmController,
      style: _itemStyle,
      onChanged: (value) {
        _newPassConfirm = value;
      },
      decoration: new InputDecoration(
        labelText: 'Confirm new password:',
        labelStyle: _itemStyle2
      ),
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
                  children: <Widget>[
                    oldPass,
                    newPass,
                    newPassConfirm,
                    changePass
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now().subtract(new Duration(days: 366 * 18)),
        firstDate: new DateTime(1975),
        lastDate: new DateTime(2019)
    );
    if(picked != null) setState(() => _birthDayController.text = picked.toString().split(' ')[0]);
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
            // clear keyword
            _sexController.text = '';
          });
        }
    );
  }
  
}