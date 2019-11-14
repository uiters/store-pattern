import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import './../Constants/dialog.dart';
import './../Constants/theme.dart' as theme;
import './../Controllers/category.controller.dart' as cateController;
import './../Controllers/food.controller.dart' as foodController;
import './../Models/category.model.dart' as cate;

class AddFoodScreen extends StatefulWidget {
  _AddFoodScreenState createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  Future<List<cate.Category>> categories = cateController.Controller.instance.categories;

  TextEditingController _idController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();

  cate.Category _category;

  File _image;

  @override
  void initState() {
    _idController.text = ' ';
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
            ? new Image.asset(
                'assets/images/food.png',
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
            var image = await foodController.Controller.instance.getImage();
            setState(() {
              _image = image;
            });
          },
        )
      ],
    );

    Widget id = new TextField(
      enabled: false,
      controller: _idController,
      style: _itemStyle,
      decoration: new InputDecoration(labelText: 'Auto-ID:*', labelStyle: _itemStyle2),
    );

    Widget name = new TextField(
      controller: _nameController,
      style: _itemStyle,
      decoration: new InputDecoration(labelText: 'Name:', labelStyle: _itemStyle2),
    );

    Widget category = new Row(
      children: <Widget>[
        new Text(
          'Category:  ',
          style: new TextStyle(
              color: theme.accentColor, fontFamily: 'Dosis', fontSize: 13.0, fontWeight: FontWeight.w500),
        ),
        FutureBuilder<List<cate.Category>>(
          future: categories,
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            if (snapshot.hasData) {
              return _buildCategory(_itemStyle, snapshot.data);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );

    Widget price = new TextField(
      controller: _priceController,
      keyboardType: TextInputType.number,
      style: _itemStyle,
      decoration: new InputDecoration(labelText: 'Price:', labelStyle: _itemStyle2),
    );

    Widget addFood = Container(
      margin: const EdgeInsets.only(top: 15.0),
      child: SizedBox(
        width: double.infinity,
        child: new RaisedButton(
          color: Colors.redAccent,
          child: new Text(
            'Add Food',
            style: _itemStyle,
          ),
          onPressed: () {
            _createFood();
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
                  children: <Widget>[id, name, category, price, addFood],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(TextStyle _itemStyle, List<cate.Category> categories) {
    List<DropdownMenuItem> items = [];
    for (int i = 0; i < categories.length; i++) {
      DropdownMenuItem item = new DropdownMenuItem(
        value: categories[i],
        child: new Text(
          categories[i].name,
          style: _itemStyle,
        ),
      );
      items.add(item);
    }

    return new DropdownButton(
        value: _category,
        items: items,
        onChanged: (value) {
          setState(() {
            _category = value;
          });
        });
  }

  void _createFood() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Confirm', style: theme.titleStyle),
            content: new Text('Do you want to create new food?', style: theme.contentStyle),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Ok', style: theme.okButtonStyle),
                onPressed: () async {
                  /* Pop screens */
                  Navigator.of(context).pop();
                  if (_nameController.text.trim() != '' &&
                      _priceController.text.trim() != '' &&
                      _category.name.trim() != '') {
                    if (await foodController.Controller.instance.insertFood(
                        _nameController.text.trim(),
                        double.parse(_priceController.text.trim()),
                        _category.id,
                        _image != null ? base64Encode(_image.readAsBytesSync()) : '')) {
                      // reload foods
                      foodController.Controller.instance.insertFoodToLocal(
                          _nameController.text.trim(),
                          _category.id,
                          _category.name,
                          double.parse(_priceController.text.trim()),
                          _image != null ? base64Encode(_image.readAsBytesSync()) : '');

                      successDialog(this.context, 'Create food success!');
                      // clear data widget
                      _nameController.clear();
                      _priceController.clear();
                      setState(() {
                        _image = null;
                      });
                    } else
                      errorDialog(this.context, 'Create new food failed.' + '\nPlease try again!');
                    return;
                  }
                  errorDialog(this.context, 'Invalid infomations.' + '\nPlease try again!');
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
}
