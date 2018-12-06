import 'package:flutter/material.dart';

import './../Models/food.model.dart';

import './../Constants/theme.dart' as theme;

class FoodDetailScreen extends StatefulWidget {
  FoodDetailScreen({key, this.food}) : super(key: key);

  final Food food;

  _FoodDetailScreenState createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {

  TextEditingController _idController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _categoryController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();

  @override
  void initState() {
    Food food = widget.food;

    _idController.text = food.id.toString();
    _nameController.text = food.name;
    _categoryController.text = food.category;
    _priceController.text = food.price.toString();
    
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
        widget.food.image == null
        ? new Image.asset(
          'assets/images/food.png',
          width: 122.0,
          height: 122.0,
          fit: BoxFit.fill,
        )
        : new Image.memory(
          widget.food.image,
          width: 122.0,
          height: 122.0,
          fit: BoxFit.fill,
        ),
      ],
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
      enabled: false,
      controller: _nameController,
      style: _itemStyle,
      decoration: new InputDecoration(
        labelText: 'Name:',
        labelStyle: _itemStyle2
      ),
    );

    Widget category = new TextField(
      enabled: false,
      controller: _categoryController,
      style: _itemStyle,
      decoration: new InputDecoration(
        labelText: 'Category:',
        labelStyle: _itemStyle2
      ),
    );

    Widget price = new TextField(
      enabled: false,
      controller: _priceController,
      style: _itemStyle,
      decoration: new InputDecoration(
        labelText: 'Price:',
        labelStyle: _itemStyle2
      ),
    );

    Widget exit = Container(
      margin: const EdgeInsets.only(top: 15.0),
      child: SizedBox(
        width: double.infinity,
        child: new RaisedButton(
          color: Colors.redAccent,
          child: new Text(
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
                    id,
                    name,
                    category,
                    price,
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
