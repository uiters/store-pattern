import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './../Models/login.model.dart';
import './../Models/home.model.dart' as home;

import './../Controllers/home.controller.dart';
import './../Controllers/cart.controller.dart' as cartController;

import './../Constants/dialog.dart';
import './../Constants/theme.dart' as theme;

import './menu.view.dart';
import './cart.view.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({key, this.account}) : super(key: key);

  final Account account;

  @override
    State<StatefulWidget> createState() {
      return new _HomeScreenState();
    }
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<home.Table>> futureTables;
  home.Table _selectedTable;
  bool isSend;

  @override
    void initState() {
      futureTables = Controller.instance.tables;
      isSend = false;
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: FutureBuilder<List<home.Table>>(
        future: futureTables,
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.hasData) {
            return new ListView.builder(
              itemExtent: 100.0,
              itemCount: (snapshot.data.length / 3).ceil(),
              itemBuilder: (context, index) => _buildTableRow(context, index, snapshot.data)
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildTableRow(BuildContext context, int index, List<home.Table> tables) {
    List<home.Table> indexes = [];
    
    int end = (index + 1) * 3;
    if (end > tables.length -1) end = tables.length;
    int begin = index * 3;

    for (int i = begin; i < end; i++) {
      indexes.add(tables[i]);
    }


    return new Container(
        child: new Row(
          children: _generateRow(context, indexes)
        ),
      );
  }

  List<Widget> _generateRow(BuildContext context, List<home.Table> indexes) {
    List<Widget> items = [];

    for (int i = 0; i < indexes.length; i++) {
      Expanded expanded = new Expanded(child: _buildTable(context, indexes[i]),);
      items.add(expanded);
    }

    for (int i = 0; i < 3 - indexes.length; i++) {
      Expanded expanded = new Expanded(child: new Container());
      items.add(expanded);
    }

    return items;
  }

  Widget _buildTable(BuildContext context, home.Table table) {
    return new GestureDetector(
      onTap: () {
        setState(() {
          _selectedTable = table;
        });
        _pushMenuScreen(table);
      },
      child: new Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: new Card(
          color: theme.primaryColor,
          child: new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Icon(
                  table.status == 1 ? Icons.people : Icons.people_outline, 
                  size: 20.0,
                  color: table.status == 1 ? Colors.redAccent : Colors.redAccent,
                ),

              ),
              // new Expanded(child: new Container()),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 30.0, right: 8.0),
                  child: new Text(
                    table.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: theme.fontColorLight, fontFamily: 'Dosis', fontSize: 20.0
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  void _pushMenuScreen(home.Table table) {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Menu • ' + _selectedTable.name,
              style: new TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),
              overflow: TextOverflow.ellipsis,
            ),
            iconTheme: new IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: new MenuScreen(table: table),
          floatingActionButton: new FloatingActionButton(
            onPressed: () {
              _pushCartScreen(table, context);
            },
            child: new Icon(Icons.add_shopping_cart),
            tooltip: 'Add To Cart',
            backgroundColor: theme.fontColor,
          ),
        );
      }),
    ).then((value) {
      if (isSend)
      setState(() {
        table.status = -1;
        table.foods.clear();
      });
    });
  }

  void _pushCartScreen(home.Table table, BuildContext menuContext) {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Cart • ' + _selectedTable.name,
              style: new TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),),
            iconTheme: new IconThemeData(color: theme.accentColor),
            centerTitle: true,
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.send),
                color: theme.accentColor,
                onPressed: () {
                  _sendBillToKitchen(table);
                },
              )
            ],
          ),
          body: new CartScreen(table: table, menuContext: context, account: widget.account, isSend: isSend,),
        );
      }),
    );
  }

  void _sendBillToKitchen(home.Table table) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            'Confirm',
            style: theme.titleStyle
          ),
          content: new Text(
            'Do you want to send bill of table ' + table.name + ' for kitchen?',
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
                isSend = true;
                if (await cartController.Controller.instance.hasBillOfTable(table.id)) { // exists bill
                  int idBill = await cartController.Controller.instance.getIdBillByTable(table.id);
                  if (await cartController.Controller.instance.updateBill(
                    idBill,
                    table.id, 
                    table.dateCheckIn,
                    DateTime.parse(new DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(DateTime.now())), 
                    0,
                    table.getTotalPrice(),
                    0,
                    widget.account.username
                  )) {
                    for (var food in table.foods) {
                      if (await cartController.Controller.instance.hasBillDetailOfBill(idBill, food.id)) {// exists billdetail
                        if (await cartController.Controller.instance.updateBillDetail(idBill, food.id, food.quantity) == false ) {
                          errorDialog(this.context, 'Send bill of table ' + table.name + ' for kitchen failed.\nPlease try again!');
                          return;
                        }
                      } else { // not exists billdetail
                        if (await cartController.Controller.instance.insertBillDetail(idBill, food.id, food.quantity) == false ) {
                          errorDialog(this.context, 'Send bill of table ' + table.name + ' for kitchen failed.\nPlease try again!');
                          return;
                        }
                      }
                    }

                    successDialog(this.context, 'Send bill of table ' + table.name + ' for kitchen successed.');
                  } else errorDialog(this.context, 'Send bill of table ' + table.name + ' for kitchen failed.\nPlease try again!');
                } else { // not exists bill
                  if (await cartController.Controller.instance.insertBill(
                    table.id, 
                    table.dateCheckIn,
                    DateTime.parse(new DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(DateTime.now())), 
                    0,
                    table.getTotalPrice(),
                    0,
                    widget.account.username
                  )) {

                    int idBill = await cartController.Controller.instance.getIdBillMax();

                    for (var food in table.foods) {
                      if (await cartController.Controller.instance.insertBillDetail(idBill, food.id, food.quantity) == false ) {
                        errorDialog(this.context, 'Send bill of table ' + table.name + ' for kitchen failed.\nPlease try again!');
                        return;
                      }
                    }

                    successDialog(this.context, 'Send bill of table ' + table.name + ' for kitchen successed.');
                  } else errorDialog(this.context, 'Send bill of table ' + table.name + ' for kitchen failed.\nPlease try again!');
                }
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
