import 'package:flutter/material.dart';

import './../Models/category.model.dart' as cate;

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
        labelText: 'ID:',
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
}