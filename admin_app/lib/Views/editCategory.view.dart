import 'package:flutter/material.dart';

import './../Models/category.model.dart' as cate;

import './../Controllers/category.controller.dart' as cateController;

import './../Constants/dialog.dart';
import './../Constants/theme.dart' as theme;

class EditCategoryScreen extends StatefulWidget {
  EditCategoryScreen({key, this.category}) : super(key: key);

  final cate.Category category;

  _EditCategoryScreenState createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  TextEditingController _idController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  
  @override
    void initState() {
      _idController.text = widget.category.id.toString();
      _nameController.text = widget.category.name;
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
        labelText: 'ID:*',
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
            _updateCategory();
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
          saveChange
        ],
        )
       ),
    );
  }

  void _updateCategory() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            'Confirm',
            style: theme.titleStyle
          ),
          content: new Text(
            'Do you want to update this category ?',
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
                  if (await cateController.Controller.instance.updateCategory(widget.category.id, _nameController.text)) {
                    cateController.Controller.instance.reloadCategories();
                    successDialog(this.context, 'Update food category success!');
                  }
                  else errorDialog(this.context, 'Update food category failed.' + '\nPlease try again!');
                  return;
                }
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
}