import 'package:flutter/material.dart';
import 'package:order_app/utils/log.dart';

import './../Constants/dialog.dart';
import './../Constants/theme.dart' as theme;
import './../Controllers/table.controller.dart';
import './../Models/table.model.dart' as model;
import './addTable.view.dart';
import './editTable.view.dart';

class TableScreen extends StatefulWidget {
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  Future<List<model.Table>> tables = Controller.instance.tables;

  TextEditingController _keywordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const TextStyle _itemStyle = TextStyle(color: theme.fontColor, fontFamily: 'Dosis', fontSize: 16.0);

    Widget controls = Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: theme.fontColorLight.withOpacity(0.2))),
      margin: EdgeInsets.only(top: 10.0, bottom: 2.0, left: 7.0, right: 7.0),
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RaisedButton(
            color: Colors.greenAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(
                  Icons.add,
                  color: theme.fontColorLight,
                  size: 19.0,
                ),
                Text(
                  'Add',
                  style: theme.contentTable,
                )
              ],
            ),
            onPressed: () {
              _pushAddTableScreen();
            },
          ),
          Container(
            width: 30.0,
          ),
          Flexible(
              child: TextField(
                  controller: _keywordController,
                  onChanged: (text) {
                    setState(() {
                      tables = Controller.instance.searchTables(_keywordController.text);
                    });
                  },
                  onSubmitted: null,
                  style: _itemStyle,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Enter your table...',
                    hintStyle: _itemStyle,
                  ))),
        ],
      ),
    );

    Widget table = FutureBuilder<List<model.Table>>(
      future: tables,
      builder: (context, snapshot) {
        if (snapshot.hasError) Log.error(snapshot.error);
        if (snapshot.hasData) {
          return _buildTable(snapshot.data);
        }
        return Center(child: CircularProgressIndicator());
      },
    );

    return Container(
      child: Column(
        children: <Widget>[controls, table],
      ),
    );
  }

  List<TableRow> _buildListRow(List<model.Table> tables) {
    List<TableRow> listRow = [_buildTableHead()];
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
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Table(
                  defaultColumnWidth: FlexColumnWidth(4.0),
                  columnWidths: {0: FlexColumnWidth(1.0), 2: FlexColumnWidth(5.0)},
                  border: TableBorder.all(width: 1.0, color: theme.fontColorLight),
                  children: _buildListRow(tables)),
            ],
          )),
    );
  }

  TableRow _buildTableHead() {
    return TableRow(children: [
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'ID',
              style: theme.headTable,
            ),
          ],
        ),
      ),
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Name',
              style: theme.headTable,
            ),
          ],
        ),
      ),
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Actions',
              style: theme.headTable,
            ),
          ],
        ),
      )
    ]);
  }

  TableRow _buildTableData(model.Table table) {
    return TableRow(children: [
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              table.id.toString(),
              style: theme.contentTable,
            ),
          ],
        ),
      ),
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              table.name,
              style: theme.contentTable,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RaisedButton(
              color: Colors.lightBlueAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    Icons.edit,
                    color: theme.fontColorLight,
                    size: 19.0,
                  ),
                  Text(
                    'Edit',
                    style: theme.contentTable,
                  )
                ],
              ),
              onPressed: () {
                _pushEditTableScreen(table);
              },
            ),
            RaisedButton(
              color: Colors.redAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    Icons.delete,
                    color: theme.fontColorLight,
                    size: 19.0,
                  ),
                  Text(
                    'Delete',
                    style: theme.contentTable,
                  )
                ],
              ),
              onPressed: () {
                _deleteTable(table);
              },
            ),
          ],
        ),
      )
    ]);
  }

  void _deleteTable(model.Table table) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm', style: theme.titleStyle),
            content: Text('Do you want to delete this table: ' + table.name + '?', style: theme.contentStyle),
            actions: <Widget>[
              FlatButton(
                  child: Text('Ok', style: theme.okButtonStyle),
                  onPressed: () async {
                    /* Pop screens */
                    Navigator.of(context).pop();
                    if (!(await Controller.instance.isTableExists(table.id))) {
                      if (await Controller.instance.deleteTable(table.id)) {
                        Controller.instance.deleteTableToLocal(table.id);
                        setState(() {
                          tables = Controller.instance.tables;
                        });
                        successDialog(this.context, 'Delete this table: ' + table.name + ' success!');
                      } else
                        errorDialog(this.context,
                            'Delete this table: ' + table.name + ' failed.' + '\nPlease try again!');
                    } else
                      errorDialog(
                          this.context,
                          'Can\'t delete this table: ' +
                              table.name +
                              '?' +
                              '\nContact with team dev for information!');
                  }),
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

  void _pushAddTableScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Add Table',
              style: TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),
            ),
            iconTheme: IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: AddCategoryScreen(),
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
      MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Table',
              style: TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),
            ),
            iconTheme: IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: EditCategoryScreen(table: table),
        );
      }),
    ).then((value) {
      setState(() {
        tables = Controller.instance.tables;
      });
    });
  }
}
