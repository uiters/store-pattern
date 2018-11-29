import 'package:flutter/material.dart';

import './../Models/table.model.dart' as model;

import './../Controllers/table.controller.dart';

import './addTable.view.dart';
import './editTable.view.dart';

import './../Constants/theme.dart' as theme;

class TableScreen extends StatefulWidget {
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  Future<List<model.Table>> tables = Controller.instance.tables;

  @override
  Widget build(BuildContext context) {
    const TextStyle _itemStyle = TextStyle(
      color: theme.fontColor, 
      fontFamily: 'Dosis', 
      fontSize: 16.0
    );
    
    Widget controls = new Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: theme.fontColorLight.withOpacity(0.2))
      ),
      margin: EdgeInsets.only(top: 10.0, bottom: 2.0, left: 7.0, right: 7.0),
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new RaisedButton(
            color: Colors.greenAccent,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Icon(Icons.add, color: theme.fontColorLight, size: 19.0,),
                new Text('Add', style: theme.contentTable,)
              ],
            ),
            onPressed: () {
              _pushAddTableScreen();
            },
          ),
          new Container(width: 30.0,),
          new Flexible(
            child: new TextField(
              onChanged: (text) {},
              onSubmitted: null,
              style: _itemStyle,
              decoration: InputDecoration.collapsed(
                  hintText: 'Enter your table...',
                  hintStyle: _itemStyle,
              )
            )
          ),
          new Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(
                  Icons.search, color: theme.fontColorLight, size: 16.0,),
                onPressed: () {
                  setState(() {});
                },
              )
          )
        ],
      ),
    );

    Widget table = new FutureBuilder<List<model.Table>>(
      future: tables,
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        if (snapshot.hasData) {
          return _buildTable(snapshot.data);
        }
        return Center(child: CircularProgressIndicator());
      },
    );

    return Container(
      child: Column(
        children: <Widget>[
          controls,
          table
        ],
      ),
    );
  }

  List<TableRow> _buildListRow(List<model.Table> tables) {
    List<TableRow> listRow = [
      _buildTableHead()
    ];
    for (var item in tables) {
      listRow.add(_buildTableData(item));
    }
    return listRow;
  }

  Widget _buildTable(List<model.Table> tables) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(7.0),
        child: new ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              new Table(
                defaultColumnWidth: FlexColumnWidth(4.0),
                columnWidths: {
                  0: FlexColumnWidth(1.0),
                  2: FlexColumnWidth(5.0)
                },
                border: TableBorder.all(width: 1.0, color: theme.fontColorLight),
                children: _buildListRow(tables)
              ),
            ],
          )
      ),
    );
  }

  TableRow _buildTableHead() {
    return new TableRow(
      children: [
        new TableCell(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('ID', style: theme.headTable,),
            ],
          ),
        ),
        new TableCell(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('Name', style: theme.headTable,),
            ],
          ),
        ),
        new TableCell(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('Actions', style: theme.headTable,),
            ],
          ),
        )
      ]
    );
  }

  TableRow _buildTableData(model.Table table) {
    return new TableRow(
      children: [
        new TableCell(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(table.id.toString(), style: theme.contentTable,),
            ],
          ),
        ),
        new TableCell(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(table.name, style: theme.contentTable, overflow: TextOverflow.ellipsis,),
            ],
          ),
        ),
        new TableCell(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new RaisedButton(
                color: Colors.lightBlueAccent,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Icon(Icons.edit, color: theme.fontColorLight, size: 19.0,),
                    new Text('Edit', style: theme.contentTable,)
                  ],
                ),
                onPressed: () {
                  _pushEditTableScreen(table);
                },
              ),
              new RaisedButton(
                color: Colors.redAccent,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Icon(Icons.delete, color: theme.fontColorLight, size: 19.0,),
                    new Text('Delete', style: theme.contentTable,)
                  ],
                ),
                onPressed: () {

                },
              ),
            ],
          ),
        )
      ]
    );
  }

  void _pushAddTableScreen() {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text(
              'Add Table',
              style: new TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),),
            iconTheme: new IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: new AddCategoryScreen(),
        );
      }),
    ).then((value) {
      setState(() {
        tables = Controller.instance.tables;
      });
    });
  }

  void _pushEditTableScreen(model.Table table) {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text(
              'Edit Table',
              style: new TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),),
            iconTheme: new IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: new EditCategoryScreen(table: table),
        );
      }),
    ).then((value) {
      setState(() {
        tables = Controller.instance.tables;
      });
    });
  }
}