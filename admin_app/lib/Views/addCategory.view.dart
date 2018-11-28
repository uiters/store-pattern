import 'package:flutter/material.dart';

import './../Controllers/category.controller.dart' as cateController;

import './../Constants/theme.dart' as theme;

class AddCategoryScreen extends StatefulWidget {
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController _idController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  
  @override
    void initState() {
      _idController.text = '  ';
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

    Widget id = new TextField(
      enabled: false,
      controller: _idController,
      style: _itemStyle,
      decoration: new InputDecoration(
        labelText: 'Auto-ID:',
        labelStyle: _itemStyle2
      ),
    );

    Widget name = new TextField(
      controller: _nameController,
      style: _itemStyle,
      decoration: new InputDecoration(
        labelText: 'Name:',
        labelStyle: _itemStyle2
      ),
    );

    Widget create = Container(
      margin: const EdgeInsets.only(top: 15.0),
      child: SizedBox(
        width: double.infinity,
        child: new RaisedButton(
          color: Colors.redAccent,
          child: new Text(
            'Create Category',
            style: _itemStyle,
          ),
          onPressed: () {
              _createCategory();
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
          id,
          name,
          create
        ],
        )
       ),
    );
  }

   void _createCategory() async {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            'Confirm',
            style: theme.titleStyle
          ),
          content: new Text(
            'Do you want create new category ?',
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
                if (_nameController.text.trim() != '') {
                  await cateController.Controller.instance.insertCategory(_nameController.text);
                  cateController.Controller.instance.reloadCategories();
                  _createSuccessful();
                  return;
                }
                _warningName();
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

  void _createSuccessful() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            'Notification',
            style: theme.titleStyle
          ),
          content: new Text(
            'Create food category success!',
            style: theme.contentStyle 
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                'Ok',
                style: theme.okButtonStyle 
              ),
              onPressed: () async {
                _nameController.clear();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  void _warningName() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            'Error',
            style: theme.errorTitleStyle
          ),
          content: new Text(
            'Invalid name.' + '\nPlease try again!',
            style: theme.contentStyle 
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                'Ok',
                style: theme.okButtonStyle 
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
}