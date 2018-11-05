import 'package:flutter/material.dart';

import './../Models/home.model.dart' as home;
import './../Models/menu.model.dart' as menu;

import './../Constants/theme.dart';

class CartScreen extends StatefulWidget {
  CartScreen({key, this.table}):super(key: key);

  final home.Table table;

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  
  TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildListFoods(context),
          _buildControls(context),
        ],
      ),
    );
  }

  Widget _buildListFoods(BuildContext context) {
    return Expanded(
      child: new Container(
        width: double.infinity,
        margin: EdgeInsets.all(5.0),
        child: new ListView.builder(
            itemExtent: 130.0,
            itemCount: widget.table.foods.length,
            itemBuilder: (_, index) => _buildFood(context, widget.table.foods[index])),
      ),
    );
  }

  Widget _buildFood(BuildContext context, menu.Food food) {
    return new Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: new Card(
          color: primaryColor,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(child: new Container()),
              new Image.memory(
                food.image,
                width: 120.0,
                height: 120.0,
                fit: BoxFit.cover,
              ),
              new Expanded(child: new Container()),
              new Column(
                children: <Widget>[
                  new Expanded(child: new Container()),
                  new Text(
                    food.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: fontColor, fontFamily: 'Dosis', fontSize: 20.0),
                  ),
                  new Text(
                    '\$' + food.price.toString(),
                    style: const TextStyle(
                        color: fontColor,
                        fontFamily: 'Dosis',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                  new Expanded(child: new Container())
                ],
              ),
              new Expanded(child: new Container()),
              new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(
                      Icons.remove,
                      size: 16.0,
                      color: fontColorLight,
                    ),
                    onPressed: () {},
                  ),
                  new Container(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: fontColor),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 1.0, bottom: 1.0, left: 4.0, right: 4.0),
                      child: new Text(
                        food.quantity.toString(),
                        style: new TextStyle(
                          color: Colors.white,
                          fontFamily: 'Dosis',
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center
                      ),
                    )
                  ),
                  new IconButton(
                    icon: new Icon(
                      Icons.add,
                      size: 16.0,
                      color: fontColorLight,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              new Expanded(child: new Container()),
              new IconButton(
                icon: new Icon(
                  Icons.delete,
                  size: 20.0,
                  color: fontColorLight,
                ),
                onPressed: () {},
              ),
              new Expanded(child: new Container()),
            ],
          ),
        ));
  }

  Widget _buildControls(BuildContext context) {
    TextStyle _itemStyle =
        new TextStyle(color: fontColor, fontFamily: 'Dosis', fontSize: 16.0);
    TextStyle _itemStyleBold = new TextStyle(
        color: fontColor,
        fontFamily: 'Dosis',
        fontSize: 16.0,
        fontWeight: FontWeight.bold);
    return new Container(
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: fontColorLight.withOpacity(0.2)),
          color: primaryColor),
      margin: EdgeInsets.only(top: 2.0, bottom: 7.0, left: 7.0, right: 7.0),
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0),
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Text(
                'Total price: ',
                style: _itemStyleBold,
              ),
              new Expanded(child: Container()),
              new Text(
                '\$400',
                style: _itemStyle,
              )
            ],
          ),
          new Divider(),
          new Row(
            children: <Widget>[
              new Text(
                'Discount: ',
                style: _itemStyleBold,
              ),
              new Expanded(child: Container()),
              new Container(
                width: 35.0,
                alignment: Alignment(1.0, 0.0),
                child: new TextField(
                    controller: _textController,
                    style: _itemStyle,
                    onChanged: null,
                    onSubmitted: null,
                    decoration: InputDecoration.collapsed(
                        hintText: '0%', hintStyle: _itemStyle)),
              ),

            ],
          ),
          new Divider(),
          new Row(
            children: <Widget>[
              new Text(
                'Final total price: ',
                style: _itemStyleBold,
              ),
              new Expanded(child: Container()),
              new Text(
                '\$360',
                style: _itemStyle,
              )
            ],
          ),
          new Divider(),
          new Container(
            alignment: Alignment(0.0, 0.0),
            color: fontColorLight,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(bottom: 8.0),
            width: double.infinity,
            child: new Text(
              'Checkout',
              style: _itemStyleBold,
            ),
          )
        ],
      ),
    );
  }
}
