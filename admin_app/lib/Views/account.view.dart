import 'package:flutter/material.dart';

import './../Models/account.model.dart';

import './../Controllers/account.controller.dart';

import './addAccount.view.dart';
import './accountDetail.view.dart';
import './editAccount.view.dart';

import './../Constants/dialog.dart';
import './../Constants/theme.dart' as theme;

class AccountScreen extends StatefulWidget {
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Future<List<Account>> accs = Controller.instance.accs;
  TextEditingController _keywordController = new TextEditingController();

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
              _pushAddAccountScreen();
            },
          ),
          new Container(width: 30.0,),
          new Flexible(
            child: new TextField(
              controller: _keywordController,
              onChanged: (text) {
                setState(() {
                  accs = Controller.instance.searchAccs(_keywordController.text);
                });
              },
              onSubmitted: null,
              style: _itemStyle,
              decoration: InputDecoration.collapsed(
                  hintText: 'Enter your username...',
                  hintStyle: _itemStyle,
              )
            )
          ),
        ],
      ),
    );

    Widget table = new FutureBuilder<List<Account>>(
      future: accs,
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

  List<TableRow> _buildListRow(List<Account> accs) {
    List<TableRow> listRow = [
      _buildTableHead()
    ];
    for (var item in accs) {
      listRow.add(_buildTableData(item));
    }
    return listRow;
  }

  Widget _buildTable(List<Account> accs) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(7.0),
        child: new ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              new Table(
                defaultColumnWidth: FlexColumnWidth(2.0),
                columnWidths: {
                  1: FlexColumnWidth(2.5),
                  3: FlexColumnWidth(3.5)
                },
                border: TableBorder.all(width: 1.0, color: theme.fontColorLight),
                children: _buildListRow(accs)
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
              new Text('Username', style: theme.headTable,),
            ],
          ),
        ),
        new TableCell(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('Display Name', style: theme.headTable,),
            ],
          ),
        ),
        new TableCell(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('Account Type', style: theme.headTable,),
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

  TableRow _buildTableData(Account acc) {
    return new TableRow(
      children: [
        new TableCell(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(acc.username.toString(), style: theme.contentTable,),
            ],
          ),
        ),
        new TableCell(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(acc.displayName, style: theme.contentTable, overflow: TextOverflow.ellipsis,),
            ],
          ),
        ),
        new TableCell(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(acc.accountType, style: theme.contentTable, overflow: TextOverflow.ellipsis,),
            ],
          ),
        ),
        new TableCell(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new IconButton(
                color: Colors.redAccent,
                icon: new Icon(Icons.edit, color: Colors.orangeAccent, size: 19.0,),
                onPressed: () {
                  _pushEditAccountScreen(acc);
                },
              ),
              new IconButton(
                color: Colors.redAccent,
                icon: new Icon(Icons.delete, color: Colors.redAccent, size: 19.0,),
                onPressed: () {

                },
              ),
              new IconButton(
                color: Colors.redAccent,
                icon: new Icon(Icons.refresh, color: Colors.greenAccent, size: 19.0,),
                onPressed: () {
                  resetAccount(acc.username);
                },
              ),
              new IconButton(
                color: Colors.redAccent,
                icon: new Icon(Icons.info, color: Colors.blueAccent, size: 19.0,),
                onPressed: () {
                  _pushDetailsAccountScreen(acc);
                },
              ),
            ],
          ),
        )
      ]
    );
  }

  void resetAccount(String username) { // only reset password
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            'Confirm',
            style: theme.titleStyle
          ),
          content: new Text(
            'Do you want to reset this account: ' + username+ '?',
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
                if (await Controller.instance.resetAcc(username, username)) {
                  successDialog(this.context, 'Reset this account: ' + username+ ' success!');
                }
                else errorDialog(this.context, 'Reset this account: ' + username+ ' failed.' + '\nPlease try again!');
              }
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

  void _pushAddAccountScreen() {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text(
              'Add Account',
              style: new TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),),
            iconTheme: new IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: new AddAccountScreen(),
        );
      }),
    ).then((value) {
      setState(() {
        accs = Controller.instance.accs;
      });
    });
  }

   void _pushEditAccountScreen(Account acc) {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text(
              'Edit Account',
              style: new TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),),
            iconTheme: new IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: new EditAccountScreen(acc: acc),
        );
      }),
    ).then((value) {
      setState(() {
        accs = Controller.instance.accs;
      });
    });
  }

  void _pushDetailsAccountScreen(Account acc) {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text(
              'Details Account',
              style: new TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),),
            iconTheme: new IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: new AccountDetailScreen(account: acc),
        );
      }),
    );
  }
}