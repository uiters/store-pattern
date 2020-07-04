import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:order_app/Controllers/notification.controller.dart';
import 'package:order_app/utils/log.dart';
import 'package:timeago/timeago.dart' as timeago;

import './../Constants/dialog.dart';
import './../Constants/theme.dart' as theme;
import './../Controllers/history.controller.dart';
import './../Models/history.model.dart' as history;
import './invoice.view.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HistoryScreenState();
  }
}

class _HistoryScreenState extends State<HistoryScreen> {
  Future<List<history.BillPlus>> bills = Controller.instance.bills;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5.0),
        child: FutureBuilder(
          future: bills,
          builder: (context, snapshot) {
            if (snapshot.hasError) Log.error(snapshot.error);
            if (snapshot.hasData) {
              return ListView.builder(
                  itemExtent: 80.0,
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) => _buildTable(context, snapshot.data[index]));
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget _buildTable(BuildContext context, history.BillPlus bill) {
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
                bill.table.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: theme.accentColor, fontFamily: 'Dosis', fontSize: 20.0),
              ),
              Expanded(child: Container()),
              Text(
                timeago.format(bill.dateCheckOut,
                    locale: 'en',
                    clock: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(DateTime.now()))),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: theme.fontColorLight,
                    fontFamily: 'Dosis',
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600),
              ),
              Expanded(child: Container()),
              Text(
                bill.account.username,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: theme.fontColorLight,
                    fontFamily: 'Dosis',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              ),
              Expanded(child: Container()),
              Text(
                '\$' + (bill.totalPrice * (1 - bill.discount / 100)).toStringAsFixed(2),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.redAccent,
                    fontFamily: 'Dosis',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500),
              ),
              Expanded(child: Container()),
              RaisedButton(
                color: Colors.lightBlueAccent,
                child: Text('Detail',
                    style: const TextStyle(
                        color: theme.fontColor,
                        fontFamily: 'Dosis',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500)),
                onPressed: () {
                  _pushInvoiceScreen(bill);
                },
              ),
              Expanded(child: Container()),
            ],
          ),
        ));
  }

  void _pushInvoiceScreen(history.BillPlus bill) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Invoice Details',
              style: TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),
            ),
            iconTheme: IconThemeData(color: theme.accentColor),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.delete,
                  size: 18.0,
                ),
                onPressed: () {
                  _deleteInvoice(context, bill);
                },
              )
            ],
          ),
          body: InvoiceScreen(bill: bill),
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
            title: Text('Confirm', style: theme.titleStyle),
            content: Text(
                'Do you want to delete invoice #' + bill.id.toString() + ' • ' + bill.table.name + '?',
                style: theme.contentStyle),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok', style: theme.okButtonStyle),
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

  Future _showNotification(history.BillPlus bill) async {
    NotificationController.show(
      'Notification',
      'Delete the invoice #' + bill.id.toString() + ' • ' + bill.table.name + ' successfully!!!',
    );
  }

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('PayLoad'),
          content: Text('Payload : $payload'),
        );
      },
    );
  }
}
