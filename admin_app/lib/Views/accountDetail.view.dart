import 'package:flutter/material.dart';

import './../Constants/theme.dart' as theme;
import './../Models/account.model.dart';

class AccountDetailScreen extends StatefulWidget {
  AccountDetailScreen({key, this.account}) : super(key: key);

  final Account account;

  _AccountDetailScreenState createState() => _AccountDetailScreenState();
}

class _AccountDetailScreenState extends State<AccountDetailScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _displayNameController = TextEditingController();
  TextEditingController _idCardController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _accountTypeController = TextEditingController();
  TextEditingController _birthDayController = TextEditingController();
  TextEditingController _sexController = TextEditingController();

  @override
  void initState() {
    Account account = widget.account;

    _usernameController.text = account.username;
    _displayNameController.text = account.displayName;
    _idCardController.text = account.idCard;
    _addressController.text = account.address;
    _phoneController.text = account.phone;
    _accountTypeController.text = account.accountType;
    _sexController.text = account.sex == 1 ? 'Male' : (account.sex == 0 ? 'Female' : 'Other');
    _birthDayController.text = account.birthday.toString().split(' ')[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _itemStyle =
        TextStyle(color: theme.fontColor, fontFamily: 'Dosis', fontSize: 16.0, fontWeight: FontWeight.w500);

    TextStyle _itemStyle2 =
        TextStyle(color: theme.accentColor, fontFamily: 'Dosis', fontSize: 18.0, fontWeight: FontWeight.w500);

    Widget avatar = Column(
      children: <Widget>[
        widget.account.image.isEmpty
            ? Image.asset(
                'assets/images/account.png',
                width: 122.0,
                height: 122.0,
                fit: BoxFit.fill,
              )
            : Image.memory(
                widget.account.image,
                width: 122.0,
                height: 122.0,
                fit: BoxFit.fill,
              ),
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
      decoration: InputDecoration(enabled: false, labelText: 'Display name:', labelStyle: _itemStyle2),
    );

    Widget idCard = TextField(
      controller: _idCardController,
      style: _itemStyle,
      decoration: InputDecoration(enabled: false, labelText: 'Id card:', labelStyle: _itemStyle2),
    );

    Widget address = TextField(
      controller: _addressController,
      style: _itemStyle,
      decoration: InputDecoration(enabled: false, labelText: 'Address:', labelStyle: _itemStyle2),
    );

    Widget phone = TextField(
      controller: _phoneController,
      style: _itemStyle,
      decoration: InputDecoration(enabled: false, labelText: 'Phone:', labelStyle: _itemStyle2),
    );

    Widget accountType = TextField(
      controller: _accountTypeController,
      style: _itemStyle,
      decoration: InputDecoration(enabled: false, labelText: 'Account Type:', labelStyle: _itemStyle2),
    );

    Widget sex = TextField(
      controller: _sexController,
      style: _itemStyle,
      decoration: InputDecoration(enabled: false, labelText: 'Sex:', labelStyle: _itemStyle2),
    );

    Widget birthDay = TextField(
      controller: _birthDayController,
      style: _itemStyle,
      decoration: InputDecoration(enabled: false, labelText: 'Birthday:', labelStyle: _itemStyle2),
    );

    Widget exit = Container(
      margin: const EdgeInsets.only(top: 15.0),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          color: Colors.redAccent,
          child: Text(
            'Exit',
            style: _itemStyle,
          ),
          onPressed: () {
            Navigator.of(context).pop();
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
                    exit
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
