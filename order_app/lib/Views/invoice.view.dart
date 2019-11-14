import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './../Constants/theme.dart' as theme;
import './../Models/history.model.dart' as history;
import './../Models/menu.model.dart' as menu;

class InvoiceScreen extends StatefulWidget {
  InvoiceScreen({key, this.bill}) : super(key: key);

  final history.BillPlus bill;

  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Column(
        children: <Widget>[_buildHeader(), _buildBody(), _buildFooter()],
      ),
    );
  }

  Widget _buildHeader() {
    return new Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: new Row(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          new Card(
              color: Colors.lightBlueAccent,
              child: new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Text(
                  widget.bill.table.name,
                  style: new TextStyle(
                    color: theme.fontColor,
                    fontFamily: 'Dosis',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )),
          Expanded(
            child: Container(),
          ),
          new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Text(
                    'ID# ' + widget.bill.id.toString() + '       ',
                    style: new TextStyle(
                        color: theme.fontColor,
                        fontFamily: 'Dosis',
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500),
                  ),
                  new Text(
                    widget.bill.account.displayName,
                    style: new TextStyle(
                        color: theme.accentColor,
                        fontFamily: 'Dosis',
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              new Text(
                new DateFormat('yyyy-MM-dd HH:mm:ss').format(widget.bill.dateCheckOut),
                style: new TextStyle(
                    color: theme.fontColor, fontFamily: 'Dosis', fontSize: 15.0, fontWeight: FontWeight.w500),
              )
            ],
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: new ListView.builder(
            itemExtent: 60.0,
            itemCount: widget.bill.table.foods.length,
            itemBuilder: (_, index) => _buildFood(widget.bill.table.foods[index])),
      ),
    );
  }

  Widget _buildFood(menu.Food food) {
    return new Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: new Card(
          color: theme.primaryColor,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(child: new Container()),
              new Text(
                food.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: theme.accentColor, fontFamily: 'Dosis', fontSize: 18.0),
              ),
              new Expanded(child: new Container()),
              new Text(
                '\$' + food.price.toString(),
                style: const TextStyle(
                    color: theme.fontColorLight,
                    fontFamily: 'Dosis',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              ),
              new Expanded(child: new Container()),
              new Text(
                food.quantity.toString(),
                style: const TextStyle(
                    color: theme.fontColorLight,
                    fontFamily: 'Dosis',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500),
              ),
              new Expanded(child: new Container()),
              new Text(
                '\$' + (food.quantity * food.price).toString(),
                style: const TextStyle(
                    color: Colors.redAccent,
                    fontFamily: 'Dosis',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500),
              ),
              new Expanded(child: new Container()),
            ],
          ),
        ));
  }

  Widget _buildFooter() {
    TextStyle _itemStyle = new TextStyle(
        color: theme.fontColor, fontFamily: 'Dosis', fontSize: 16.0, fontWeight: FontWeight.w500);

    TextStyle _itemStyle2 = new TextStyle(
        color: Colors.redAccent, fontFamily: 'Dosis', fontSize: 16.0, fontWeight: FontWeight.w500);

    return new Container(
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: theme.fontColorLight.withOpacity(0.2)),
          color: theme.primaryColor),
      margin: EdgeInsets.only(top: 2.0, bottom: 7.0, left: 7.0, right: 7.0),
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0),
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Text(
                'Subtotal: ',
                style: _itemStyle,
              ),
              new Expanded(child: Container()),
              new Text(
                '\$' + widget.bill.totalPrice.toStringAsFixed(2),
                style: _itemStyle,
              )
            ],
          ),
          new Divider(),
          new Row(
            children: <Widget>[
              new Text(
                'Discount: ',
                style: _itemStyle,
              ),
              new Expanded(child: Container()),
              new Text(
                widget.bill.discount.toString() + '%',
                style: _itemStyle,
              )
            ],
          ),
          new Divider(),
          new Row(
            children: <Widget>[
              new Text(
                'Total: ',
                style: _itemStyle,
              ),
              new Expanded(child: Container()),
              new Text(
                '\$' + (widget.bill.totalPrice * (1 - widget.bill.discount / 100)).toStringAsFixed(2),
                style: _itemStyle2,
              )
            ],
          ),
        ],
      ),
    );
  }
}
