import 'package:flutter/material.dart';

import './../Models/home.model.dart' as home;
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

  Future<List<home.Table>> futureTables = Controller.instance.tables;

  home.Table _selectedTable;

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
      ),
    );
  }

  void _pushMenuScreen(home.Table table) {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Menu ~ ' + _selectedTable.name,
              style: new TextStyle(color: accentColor, fontFamily: 'Dosis'),
              overflow: TextOverflow.ellipsis,
            ),
            iconTheme: new IconThemeData(color: accentColor),
            centerTitle: true,
          ),
          body: new MenuScreen(table: table),
          floatingActionButton: new FloatingActionButton(
            onPressed: () {
              _pushCartScreen(table);
            },
            child: new Icon(Icons.add_shopping_cart),
            tooltip: 'Add To Cart',
            backgroundColor: fontColor,
          ),
        );
      }),
    );
  }

  void _pushCartScreen(home.Table table) {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Cart ~ ' + _selectedTable.name,
              style: new TextStyle(color: accentColor, fontFamily: 'Dosis'),),
            iconTheme: new IconThemeData(color: accentColor),
            centerTitle: true,
          ),
          body: new CartScreen(table: table),
        );
      }),
    );
  }
}
