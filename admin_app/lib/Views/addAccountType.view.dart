import 'package:flutter/material.dart';

import './../Constants/dialog.dart';
import './../Constants/theme.dart' as theme;
import './../Controllers/accountType.controller.dart';

class AddAccountTypeScreen extends StatefulWidget {
  _AddAccountTypeScreenState createState() => _AddAccountTypeScreenState();
}

class _AddAccountTypeScreenState extends State<AddAccountTypeScreen> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    _idController.text = '  ';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _itemStyle =
        TextStyle(color: theme.fontColor, fontFamily: 'Dosis', fontSize: 16.0, fontWeight: FontWeight.w500);

    TextStyle _itemStyle2 =
        TextStyle(color: theme.accentColor, fontFamily: 'Dosis', fontSize: 18.0, fontWeight: FontWeight.w500);

    Widget id = TextField(
      enabled: false,
      controller: _idController,
      style: _itemStyle,
      decoration: InputDecoration(labelText: 'Auto-ID:*', labelStyle: _itemStyle2),
    );

    Widget name = TextField(
      controller: _nameController,
      style: _itemStyle,
      decoration: InputDecoration(labelText: 'Name:', labelStyle: _itemStyle2),
    );

    Widget create = Container(
      margin: const EdgeInsets.only(top: 15.0),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          color: Colors.redAccent,
          child: Text(
            'Create Account Type',
            style: _itemStyle,
          ),
          onPressed: () {
            _createAccType();
          },
        ),
      ),
    );

    return Container(
      child: Container(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
            scrollDirection: Axis.vertical,
            children: <Widget>[id, name, create],
          )),
    );
  }

  void _createAccType() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm', style: theme.titleStyle),
            content: Text('Do you want to create  account type ?', style: theme.contentStyle),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok', style: theme.okButtonStyle),
                onPressed: () async {
                  /* Pop screens */
                  Navigator.of(context).pop();
                  if (_nameController.text.trim() != '') {
                    if (await Controller.instance.insertAccType(_nameController.text)) {
                      Controller.instance.insertAccTypeToLocal(_nameController.text);
                      successDialog(this.context, 'Create  account type success!');
                      _nameController.clear();
                    } else
                      errorDialog(this.context, 'Create  account type failed.' + '\nPlease try again!');
                    return;
                  }
                  errorDialog(this.context, 'Invalid name.' + '\nPlease try again!');
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
}
