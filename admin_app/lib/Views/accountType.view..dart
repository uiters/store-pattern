import 'package:flutter/material.dart';

import './../Constants/dialog.dart';
import './../Constants/theme.dart' as theme;
import './../Controllers/accountType.controller.dart';
import './../Models/accountType.model.dart';
import './addAccountType.view.dart';
import './editAccountType.view.dart';

class AccountTypeScreen extends StatefulWidget {
  _AccountTypeScreenState createState() => _AccountTypeScreenState();
}

class _AccountTypeScreenState extends State<AccountTypeScreen> {
  Future<List<AccountType>> accTypes = Controller.instance.accTypes;
  TextEditingController _keywordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    const TextStyle _itemStyle = TextStyle(color: theme.fontColor, fontFamily: 'Dosis', fontSize: 16.0);

    Widget controls = new Container(
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: theme.fontColorLight.withOpacity(0.2))),
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
                new Icon(
                  Icons.add,
                  color: theme.fontColorLight,
                  size: 19.0,
                ),
                new Text(
                  'Add',
                  style: theme.contentTable,
                )
              ],
            ),
            onPressed: () {
              _pushAddAccountTypeScreen();
            },
          ),
          new Container(
            width: 30.0,
          ),
          new Flexible(
              child: new TextField(
                  controller: _keywordController,
                  onChanged: (text) {
                    setState(() {
                      accTypes = Controller.instance.searchAccTypes(_keywordController.text);
                    });
                  },
                  onSubmitted: null,
                  style: _itemStyle,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Enter your account type...',
                    hintStyle: _itemStyle,
                  ))),
        ],
      ),
    );

    Widget table = new FutureBuilder<List<AccountType>>(
      future: accTypes,
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
        children: <Widget>[controls, table],
      ),
    );
  }

  List<TableRow> _buildListRow(List<AccountType> accTypes) {
    List<TableRow> listRow = [_buildTableHead()];
    for (var item in accTypes) {
      listRow.add(_buildTableData(item));
    }
    return listRow;
  }

  Widget _buildTable(List<AccountType> accTypes) {
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
                  columnWidths: {0: FlexColumnWidth(1.0), 2: FlexColumnWidth(5.0)},
                  border: TableBorder.all(width: 1.0, color: theme.fontColorLight),
                  children: _buildListRow(accTypes)),
            ],
          )),
    );
  }

  TableRow _buildTableHead() {
    return new TableRow(children: [
      new TableCell(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'ID',
              style: theme.headTable,
            ),
          ],
        ),
      ),
      new TableCell(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Name',
              style: theme.headTable,
            ),
          ],
        ),
      ),
      new TableCell(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Actions',
              style: theme.headTable,
            ),
          ],
        ),
      )
    ]);
  }

  TableRow _buildTableData(AccountType accType) {
    return new TableRow(children: [
      new TableCell(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              accType.id.toString(),
              style: theme.contentTable,
            ),
          ],
        ),
      ),
      new TableCell(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              accType.name,
              style: theme.contentTable,
              overflow: TextOverflow.ellipsis,
            ),
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
                  new Icon(
                    Icons.edit,
                    color: theme.fontColorLight,
                    size: 19.0,
                  ),
                  new Text(
                    'Edit',
                    style: theme.contentTable,
                  )
                ],
              ),
              onPressed: () {
                _pushEditAccountTypeScreen(accType);
              },
            ),
            new RaisedButton(
              color: Colors.redAccent,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Icon(
                    Icons.delete,
                    color: theme.fontColorLight,
                    size: 19.0,
                  ),
                  new Text(
                    'Delete',
                    style: theme.contentTable,
                  )
                ],
              ),
              onPressed: () {
                _deleteAccType(accType);
              },
            ),
          ],
        ),
      )
    ]);
  }

  void _deleteAccType(AccountType accType) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Confirm', style: theme.titleStyle),
            content: new Text('Do you want to delete this account type: ' + accType.name + '?',
                style: theme.contentStyle),
            actions: <Widget>[
              new FlatButton(
                  child: new Text('Ok', style: theme.okButtonStyle),
                  onPressed: () async {
                    /* Pop screens */
                    Navigator.of(context).pop();
                    if (!(await Controller.instance.isAccTypeExists(accType.id))) {
                      if (await Controller.instance.deleteAccType(accType.id)) {
                        Controller.instance.deleteAccTypeToLocal(accType.id);
                        setState(() {
                          accTypes = Controller.instance.accTypes;
                        });
                        successDialog(
                            this.context, 'Delete this account type: ' + accType.name + ' success!');
                      } else
                        errorDialog(this.context,
                            'Delete this account type: ' + accType.name + ' failed.' + '\nPlease try again!');
                    } else
                      errorDialog(
                          this.context,
                          'Can\'t delete this account type: ' +
                              accType.name +
                              '?' +
                              '\nContact with team dev for information!');
                  }),
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

  void _pushAddAccountTypeScreen() {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text(
              'Add Account Type',
              style: new TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),
            ),
            iconTheme: new IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: new AddAccountTypeScreen(),
        );
      }),
    ).then((value) {
      setState(() {
        accTypes = Controller.instance.accTypes;
      });
    });
  }

  void _pushEditAccountTypeScreen(AccountType accType) {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text(
              'Edit Account Type',
              style: new TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),
            ),
            iconTheme: new IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: new EditAccountTypeScreen(accType: accType),
        );
      }),
    ).then((value) {
      setState(() {
        accTypes = Controller.instance.accTypes;
      });
    });
  }
}
