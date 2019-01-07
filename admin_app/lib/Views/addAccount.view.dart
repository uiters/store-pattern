import 'dart:io';

import 'package:flutter/material.dart';

import './../Controllers/account.controller.dart';

import './../Constants/dialog.dart';
import './../Constants/theme.dart' as theme;

class AddAccountScreen extends StatefulWidget {
  _AddAccountScreenState createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _displayNameController = new TextEditingController();
  TextEditingController _idCardController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _accountTypeController = new TextEditingController();
  TextEditingController _birthDayController = new TextEditingController();

  String _sex;

  File _image;
  
  @override
    void initState() {
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
        _image == null 
        ? new Image.asset(
            'assets/images/account.png',
            width: 122.0,
            height: 122.0,
            fit: BoxFit.fill,
        )
        : new Image.file(
            _image,
            width: 122.0,
            height: 122.0,
            fit: BoxFit.fill,
          ),
        new Container(height: 15.0,),
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
      decoration: new InputDecoration(
        labelText: 'Username:*',
        labelStyle: _itemStyle2
      ),
    );

    Widget displayName = new TextField(
      controller: _displayNameController,
      style: _itemStyle,
      decoration: new InputDecoration(
        labelText: 'Display name:',
        labelStyle: _itemStyle2
      ),
    );

    Widget idCard = new TextField(
      controller: _idCardController,
      style: _itemStyle,
      decoration: new InputDecoration(
        labelText: 'Id card:',
        labelStyle: _itemStyle2
      ),
    );

    Widget address = new TextField(
      controller: _addressController,
      style: _itemStyle,
      decoration: new InputDecoration(
        labelText: 'Address:',
        labelStyle: _itemStyle2
      ),
    );

    Widget phone = new TextField(
      controller: _phoneController,
      style: _itemStyle,
      decoration: new InputDecoration(
        labelText: 'Phone:',
        labelStyle: _itemStyle2
      ),
    );

    Widget accountType = new TextField(
      controller: _accountTypeController,
      style: _itemStyle,
      decoration: new InputDecoration(
        enabled: false,
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
            decoration: new InputDecoration(
              enabled: false,
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

    Widget create = Container(
      margin: const EdgeInsets.only(top: 15.0),
      child: SizedBox(
        width: double.infinity,
        child: new RaisedButton(
          color: Colors.redAccent,
          child: new Text(
            'Create Account',
            style: _itemStyle,
          ),
          onPressed: () {
              _createAcc();
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
            create
          ],
        )
       ),
    );
  }

  void _createAcc() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            'Confirm',
            style: theme.titleStyle
          ),
          content: new Text(
            'Do you want to create new account?',
            style: theme.contentStyle 
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                'Ok',
                style: theme.okButtonStyle 
              ),
              onPressed: () async {
                /* Pop screens */
                Navigator.of(context).pop();
                // if (_nameController.text.trim() != '') {
                //   if (await Controller.instance.insertAccType(_nameController.text)) {
                //     Controller.instance.reloadAccTypes();
                //     successDialog(this.context, 'Create new account success!');
                //     _nameController.clear();
                //   }
                //   else errorDialog(this.context, 'Create new account failed.' + '\nPlease try again!');
                //   return;
                // }
                errorDialog(this.context, 'Invalid name.' + '\nPlease try again!');
              },
            ),
            new FlatButton(
              child: new Text(
                'Cancel',
                style: theme.cancelButtonStyle  
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now().subtract(new Duration(days: 365 * 18)),
        firstDate: new DateTime(1975),
        lastDate: new DateTime(2019)
    );
    if (picked != null) setState(() => _birthDayController.text = picked.toString().split(' ')[0]);
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
        }
    );
  }

}