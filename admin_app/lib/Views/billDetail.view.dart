import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:order_app/utils/log.dart';

import './../Constants/theme.dart' as theme;
import './../Controllers/bill.controller.dart';
import './../Models/bill.model.dart';

class BillDetailScreen extends StatefulWidget {
  BillDetailScreen({key, this.bill}) : super(key: key);

  final Bill bill;

  _BillDetailScreenState createState() => _BillDetailScreenState();
}

class _BillDetailScreenState extends State<BillDetailScreen> {
  Future<List<Food>> foods;

  @override
  void initState() {
    foods = Controller.instance.getFoodByBill(widget.bill.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_buildHeader(), _buildBody(), _buildFooter()],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          Card(
              color: Colors.lightBlueAccent,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.bill.nameTable,
                  style: TextStyle(
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
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'ID# ' + widget.bill.id.toString() + '       ',
                    style: TextStyle(
                        color: theme.fontColor,
                        fontFamily: 'Dosis',
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    widget.bill.userName,
                    style: TextStyle(
                        color: theme.accentColor,
                        fontFamily: 'Dosis',
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              Text(
                DateFormat('yyyy-MM-dd HH:mm:ss').format(widget.bill.dateCheckOut),
                style: TextStyle(
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
          child: FutureBuilder<List<Food>>(
            future: foods,
            builder: (context, snapshot) {
              if (snapshot.hasError) Log.error(snapshot.error);
              if (snapshot.hasData) {
                return ListView.builder(
                    itemExtent: 60.0,
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) => _buildFood(snapshot.data[index]));
              }
              return Center(child: CircularProgressIndicator());
            },
          )),
    );
  }

  Widget _buildFood(Food food) {
    return Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: Card(
          color: theme.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Container()),
              Text(
                food.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: theme.accentColor, fontFamily: 'Dosis', fontSize: 18.0),
              ),
              Expanded(child: Container()),
              Text(
                '\$' + food.price.toString(),
                style: const TextStyle(
                    color: theme.fontColorLight,
                    fontFamily: 'Dosis',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              ),
              Expanded(child: Container()),
              Text(
                food.quantity.toString(),
                style: const TextStyle(
                    color: theme.fontColorLight,
                    fontFamily: 'Dosis',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500),
              ),
              Expanded(child: Container()),
              Text(
                '\$' + (food.quantity * food.price).toString(),
                style: const TextStyle(
                    color: Colors.redAccent,
                    fontFamily: 'Dosis',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500),
              ),
              Expanded(child: Container()),
            ],
          ),
        ));
  }

  Widget _buildFooter() {
    TextStyle _itemStyle =
        TextStyle(color: theme.fontColor, fontFamily: 'Dosis', fontSize: 16.0, fontWeight: FontWeight.w500);

    TextStyle _itemStyle2 =
        TextStyle(color: Colors.redAccent, fontFamily: 'Dosis', fontSize: 16.0, fontWeight: FontWeight.w500);

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: theme.fontColorLight.withOpacity(0.2)),
          color: theme.primaryColor),
      margin: EdgeInsets.only(top: 2.0, bottom: 7.0, left: 7.0, right: 7.0),
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Subtotal: ',
                style: _itemStyle,
              ),
              Expanded(child: Container()),
              Text(
                '\$' + widget.bill.totalPrice.toStringAsFixed(2),
                style: _itemStyle,
              )
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Text(
                'Discount: ',
                style: _itemStyle,
              ),
              Expanded(child: Container()),
              Text(
                widget.bill.discount.toString() + '%',
                style: _itemStyle,
              )
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Text(
                'Total: ',
                style: _itemStyle,
              ),
              Expanded(child: Container()),
              Text(
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
