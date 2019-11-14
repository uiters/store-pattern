import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import './../Constants/dialog.dart';
import './../Constants/theme.dart' as theme;
import './../Controllers/history.controller.dart';
import './../Models/history.model.dart' as history;
import './invoice.view.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HistoryScreenState();
  }
}

class _HistoryScreenState extends State<HistoryScreen> {
  Future<List<history.BillPlus>> bills = Controller.instance.bills;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('app_icon');
    var ios = new IOSInitializationSettings();
    var initSetting = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(initSetting);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5.0),
        child: new FutureBuilder(
          future: bills,
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            if (snapshot.hasData) {
              return new ListView.builder(
                  itemExtent: 80.0,
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) => _buildTable(context, snapshot.data[index]));
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget _buildTable(BuildContext context, history.BillPlus bill) {
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
                bill.table.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: theme.accentColor, fontFamily: 'Dosis', fontSize: 20.0),
              ),
              new Expanded(child: new Container()),
              new Text(
                timeago.format(bill.dateCheckOut,
                    locale: 'en',
                    clock: DateTime.parse(new DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(DateTime.now()))),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: theme.fontColorLight,
                    fontFamily: 'Dosis',
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600),
              ),
              new Expanded(child: new Container()),
              new Text(
                bill.account.username,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: theme.fontColorLight,
                    fontFamily: 'Dosis',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              ),
              new Expanded(child: new Container()),
              new Text(
                '\$' + (bill.totalPrice * (1 - bill.discount / 100)).toStringAsFixed(2),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.redAccent,
                    fontFamily: 'Dosis',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500),
              ),
              new Expanded(child: new Container()),
              new RaisedButton(
                color: Colors.lightBlueAccent,
                child: new Text('Detail',
                    style: const TextStyle(
                        color: theme.fontColor,
                        fontFamily: 'Dosis',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500)),
                onPressed: () {
                  _pushInvoiceScreen(bill);
                },
              ),
              new Expanded(child: new Container()),
            ],
          ),
        ));
  }

  void _pushInvoiceScreen(history.BillPlus bill) {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text(
              'Invoice Details',
              style: new TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),
            ),
            iconTheme: new IconThemeData(color: theme.accentColor),
            centerTitle: true,
            actions: <Widget>[
              new IconButton(
                icon: new Icon(
                  Icons.delete,
                  size: 18.0,
                ),
                onPressed: () {
                  _deleteInvoice(context, bill);
                },
              )
            ],
          ),
          body: new InvoiceScreen(bill: bill),
        );
      }),
    ).then((value) {
      setState(() {
        bills = Controller.instance.bills;
      });
    });
  }

  void _deleteInvoice(BuildContext invoiceContext, history.BillPlus bill) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Confirm', style: theme.titleStyle),
            content: new Text(
                'Do you want to delete invoice #' + bill.id.toString() + ' • ' + bill.table.name + '?',
                style: theme.contentStyle),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Ok', style: theme.okButtonStyle),
                onPressed: () async {
                  /* Pop screens */
                  Navigator.of(context).pop();
                  Controller.instance.removeBill(bill.id);
                  Navigator.of(invoiceContext).pop();

                  if (await Controller.instance.deleteBill(bill.id)) {
                    bills.then((values) {
                      values.remove(bill);
                    });

                    _showNotification(bill);
                  } else
                    errorDialog(
                        this.context,
                        'Delete the invoice #' +
                            bill.id.toString() +
                            ' • ' +
                            bill.table.name +
                            '.\nPlease try again!');
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

  Future _showNotification(history.BillPlus bill) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics =
        new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        'Notification',
        'Delete the invoice #' + bill.id.toString() + ' • ' + bill.table.name + ' successfully!!!',
        platformChannelSpecifics,
        payload: 'item x');
  }

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }
}
