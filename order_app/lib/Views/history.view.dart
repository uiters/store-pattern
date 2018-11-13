import 'package:flutter/material.dart';

import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';

import './../Models/history.model.dart' as history;
import './../Models/home.model.dart' as home;

import './../Controllers/history.controller.dart';

import './invoice.view.dart';
import './editInvoice.view.dart';

import './../Constants/theme.dart' as theme;

class HistoryScreen extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      return new _HistoryScreenState();
    }
}

class _HistoryScreenState extends State<HistoryScreen> {

  Future<List<history.BillPlus>> bills = Controller.instance.bills;

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
              itemBuilder: (_, index) => _buildTable(context, snapshot.data[index])
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      )
    );
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
            style: const TextStyle(
              color: theme.accentColor, 
              fontFamily: 'Dosis', 
              fontSize: 20.0
            ),
          ),
          new Expanded(child: new Container()),
          new Text(
            timeago.format(
              bill.dateCheckOut, 
              locale: 'en', 
              clock: DateTime.parse(new DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(DateTime.now()))
            ),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: theme.fontColor,
              fontFamily: 'Dosis',
              fontSize: 13.0,
              fontWeight: FontWeight.w600
            ),
          ),
          new Expanded(child: new Container()),
          new Text(
            '\$' + (bill.totalPrice * (1 - bill.discount / 100)).toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: theme.fontColor,
              fontFamily: 'Dosis',
              fontSize: 14.0,
              fontWeight: FontWeight.w500
            ),
          ),
          new Expanded(child: new Container()),
          new RaisedButton(
            color: Colors.lightBlueAccent,
            child: new Text(
              'Detail',
              style: const TextStyle(
                color: theme.fontColor,
                fontFamily: 'Dosis',
                fontSize: 15.0,
                fontWeight: FontWeight.w500)
              ),
            onPressed: () {
              _pushInvoiceScreen();
            },
          ),
          new Expanded(child: new Container()),
        ],
      ),
    )
    );
  }

  void _pushInvoiceScreen() {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Invoice Details',
              style: new TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),),
            iconTheme: new IconThemeData(color: theme.accentColor),
            centerTitle: true,
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.edit, size: 18.0,),
                onPressed: () {
                  _pushEditInvoiceScreen();
                },
              )
            ],
          ),
          body: new InvoiceScreen(),
        );
      }),
    );
  }

  void _pushEditInvoiceScreen() {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Edit Invoice • Table 1',
              style: new TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),),
            iconTheme: new IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: new EditInvoice(),
        );
      }),
    );
  }

}
