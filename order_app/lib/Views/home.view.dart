import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:order_app/utils/log.dart';

import './../Constants/dialog.dart';
import './../Constants/theme.dart' as theme;
import './../Controllers/cart.controller.dart' as cartController;
import './../Controllers/home.controller.dart';
import './../Models/home.model.dart' as home;
import './../Models/login.model.dart';
import './cart.view.dart';
import './menu.view.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({key, this.account}) : super(key: key);

  final Account account;

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<home.Table>> futureTables;
  home.Table _selectedTable;

  @override
  void initState() {
    futureTables = Controller.instance.tables;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: FutureBuilder<List<home.Table>>(
        future: futureTables,
        builder: (context, snapshot) {
          if (snapshot.hasError) Log.error(snapshot.error);
          if (snapshot.hasData) {
            return ListView.builder(
                itemExtent: 100.0,
                itemCount: (snapshot.data.length / 3).ceil(),
                itemBuilder: (context, index) => _buildTableRow(context, index, snapshot.data));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildTableRow(BuildContext context, int index, List<home.Table> tables) {
    List<home.Table> indexes = [];

    int end = (index + 1) * 3;
    if (end > tables.length - 1) end = tables.length;
    int begin = index * 3;

    for (int i = begin; i < end; i++) {
      indexes.add(tables[i]);
    }

    return Container(
      child: Row(children: _generateRow(context, indexes)),
    );
  }

  List<Widget> _generateRow(BuildContext context, List<home.Table> indexes) {
    List<Widget> items = [];

    for (int i = 0; i < indexes.length; i++) {
      Expanded expanded = Expanded(
        child: _buildTable(context, indexes[i]),
      );
      items.add(expanded);
    }

    for (int i = 0; i < 3 - indexes.length; i++) {
      Expanded expanded = Expanded(child: Container());
      items.add(expanded);
    }

    return items;
  }

  Widget _buildTable(BuildContext context, home.Table table) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTable = table;
        });
        _pushMenuScreen(table);
      },
      child: Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          child: Card(
            color: theme.primaryColor,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    table.status == 1 ? Icons.people : Icons.people_outline,
                    size: 20.0,
                    color: table.status == 1 ? Colors.redAccent : Colors.redAccent,
                  ),
                ),
                //  Expanded(child:  Container()),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 30.0, right: 8.0),
                    child: Text(
                      table.name,
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(color: theme.fontColorLight, fontFamily: 'Dosis', fontSize: 20.0),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  void _pushMenuScreen(home.Table table) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Menu • ' + _selectedTable.name,
              style: TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),
              overflow: TextOverflow.ellipsis,
            ),
            iconTheme: IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: MenuScreen(table: table),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _pushCartScreen(table, context);
            },
            child: Icon(Icons.add_shopping_cart),
            tooltip: 'Add To Cart',
            backgroundColor: theme.fontColor,
          ),
        );
      }),
    );
  }

  void _pushCartScreen(home.Table table, BuildContext menuContext) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Cart • ' + _selectedTable.name,
              style: TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),
            ),
            iconTheme: IconThemeData(color: theme.accentColor),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.send),
                color: theme.accentColor,
                onPressed: () {
                  _sendBillToKitchen(table);
                },
              )
            ],
          ),
          body: CartScreen(table: table, menuContext: context, account: widget.account),
        );
      }),
    );
  }

  void _sendBillToKitchen(home.Table table) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm', style: theme.titleStyle),
            content: Text('Do you want to send bill of table ' + table.name + ' for kitchen?',
                style: theme.contentStyle),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok', style: theme.okButtonStyle),
                onPressed: () async {
                  Navigator.of(context).pop();
                  cartController.Controller.instance.isSend = false;
                  if (await cartController.Controller.instance.hasBillOfTable(table.id)) {
                    // exists bill
                    int idBill = await cartController.Controller.instance.getIdBillByTable(table.id);
                    if (await cartController.Controller.instance.updateBill(
                        idBill,
                        table.id,
                        table.dateCheckIn,
                        DateTime.parse(DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(DateTime.now())),
                        0,
                        table.getTotalPrice(),
                        0,
                        widget.account.username)) {
                      for (var food in table.foods) {
                        if (await cartController.Controller.instance.hasBillDetailOfBill(idBill, food.id)) {
                          // exists billdetail
                          if (await cartController.Controller.instance
                                  .updateBillDetail(idBill, food.id, food.quantity) ==
                              false) {
                            errorDialog(
                                this.context,
                                'Send bill of table ' +
                                    table.name +
                                    ' for kitchen failed.\nPlease try again!');
                            return;
                          }
                        } else {
                          // not exists billdetail
                          if (await cartController.Controller.instance
                                  .insertBillDetail(idBill, food.id, food.quantity) ==
                              false) {
                            errorDialog(
                                this.context,
                                'Send bill of table ' +
                                    table.name +
                                    ' for kitchen failed.\nPlease try again!');
                            return;
                          }
                        }
                      }
                      cartController.Controller.instance.isSend = true;
                      successDialog(
                          this.context, 'Send bill of table ' + table.name + ' for kitchen successed.');
                    } else
                      errorDialog(this.context,
                          'Send bill of table ' + table.name + ' for kitchen failed.\nPlease try again!');
                  } else {
                    // not exists bill
                    if (await cartController.Controller.instance.insertBill(
                        table.id,
                        table.dateCheckIn,
                        DateTime.parse(DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(DateTime.now())),
                        0,
                        table.getTotalPrice(),
                        0,
                        widget.account.username)) {
                      int idBill = await cartController.Controller.instance.getIdBillMax();

                      for (var food in table.foods) {
                        if (await cartController.Controller.instance
                                .insertBillDetail(idBill, food.id, food.quantity) ==
                            false) {
                          errorDialog(this.context,
                              'Send bill of table ' + table.name + ' for kitchen failed.\nPlease try again!');
                          return;
                        }
                      }
                      cartController.Controller.instance.isSend = true;
                      successDialog(
                          this.context, 'Send bill of table ' + table.name + ' for kitchen successed.');
                    } else
                      errorDialog(this.context,
                          'Send bill of table ' + table.name + ' for kitchen failed.\nPlease try again!');
                  }
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
