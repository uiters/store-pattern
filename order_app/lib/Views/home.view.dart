import 'package:flutter/material.dart';

import './../Models/home.model.dart' as model;
import './../Controllers/home.controller.dart';

import './../Constants/theme.dart';
import './menu.view.dart';
import './cart.view.dart';

class HomeScreen extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      return new _HomeScreenState();
    }
}

class _HomeScreenState extends State<HomeScreen> {

  Future<List<model.Table>> tables = Controller.instance.tables;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: FutureBuilder<List<model.Table>>(
        future: tables,
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
            ? new ListView.builder(
              itemExtent: 100.0,
              itemCount: (snapshot.data.length / 3).ceil(),
              itemBuilder: (context, index) => _buildTableRow(context, index, snapshot.data)
            )
            : Center(child: CircularProgressIndicator());
        },
      ),

    );
  }

  Widget _buildTableRow(BuildContext context, int index, List<model.Table> tables) {
    List<model.Table> indexes = [];
    
    int end = (index + 1) * 3;
    if (end > tables.length -1) end = tables.length;
    int begin = index * 3;

    for (int i = begin; i < end; i++) {
      indexes.add(tables[i]);
    }


    return GestureDetector(
      onTap: () {
        _pushMenuScreen();
      },
      child: new Container(
        child: new Row(
          children: _generateRow(context, indexes)
        ),
      ),
    );
  }

  List<Widget> _generateRow(BuildContext context, List<model.Table> indexes) {
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

  Widget _buildTable(BuildContext context, model.Table table) {
    return new Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: new Card(
          color: primaryColor,
          child: new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Icon(
                  table.status == 1 ? Icons.people : Icons.people_outline, 
                  size: 20.0,
                  color: table.status == 1 ? accentColor : fontColorLight,
                  ),
              ),
              new Expanded(child: new Container()),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, right: 8.0),
                child: new Text(
                  table.name,
                  style: const TextStyle(
                      color: fontColor, fontFamily: 'Dosis', fontSize: 20.0
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

  void _pushMenuScreen() {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Select Foods',
              style: new TextStyle(color: accentColor, fontFamily: 'Dosis'),),
            iconTheme: new IconThemeData(color: accentColor),
            centerTitle: true,
          ),
          body: new MenuScreen(),
          floatingActionButton: new FloatingActionButton(
            onPressed: () {
              _pushCartScreen();
            },
            child: new Icon(Icons.add_shopping_cart),
            tooltip: 'Add To Cart',
            backgroundColor: fontColor,
          ),
        );
      }),
    );
  }

  void _pushCartScreen() {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Cart',
              style: new TextStyle(color: accentColor, fontFamily: 'Dosis'),),
            iconTheme: new IconThemeData(color: accentColor),
            centerTitle: true,
          ),
          body: new CartScreen(),
//          floatingActionButton: new FloatingActionButton(
//            onPressed: () {},
//            child: new Icon(Icons.payment),
//            tooltip: 'Payment',
//            backgroundColor: fontColor,
//          ),
        );
      }),
    );
  }
}
