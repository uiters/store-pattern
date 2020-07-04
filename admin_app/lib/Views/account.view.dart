import 'package:flutter/material.dart';

import './../Constants/dialog.dart';
import './../Constants/theme.dart' as theme;
import './../Controllers/account.controller.dart';
import './../Models/account.model.dart';
import './accountDetail.view.dart';
import './addAccount.view.dart';
import './editAccount.view.dart';

class AccountScreen extends StatefulWidget {
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Future<List<Account>> accs = Controller.instance.listAccount;
  TextEditingController _keywordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const TextStyle _itemStyle =
        TextStyle(color: theme.fontColor, fontFamily: 'Dosis', fontSize: 16.0);

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
              _pushAddAccountScreen();
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
                      accs = Controller.instance.searchAccs(_keywordController.text);
                    });
                  },
                  onSubmitted: null,
                  style: _itemStyle,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Enter your username...',
                    hintStyle: _itemStyle,
                  ))),
        ],
      ),
    );

    Widget table = FutureBuilder<List<Account>>(
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
        children: <Widget>[controls, table],
      ),
    );
  }

  Widget _buildTable(List<Account> accs) {
    return Expanded(
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(7.0),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Table(
                  defaultColumnWidth: FlexColumnWidth(2.0),
                  columnWidths: {1: FlexColumnWidth(2.5), 3: FlexColumnWidth(3.5)},
                  border: TableBorder.all(width: 1.0, color: theme.fontColorLight),
                  children: _buildListRow(accs)),
            ],
          )),
    );
  }

  List<TableRow> _buildListRow(List<Account> accs) {
    List<TableRow> listRow = [_buildTableHead()];
    for (var item in accs) {
      listRow.add(_buildTableData(item));
    }
    return listRow;
  }

  TableRow _buildTableHead() {
    return TableRow(children: [
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Username',
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
              'Display Name',
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
              'Account Type',
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

  TableRow _buildTableData(Account acc) {
    return TableRow(children: [
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              acc.username.toString() ?? '',
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
              acc.displayName ?? '',
              style: theme.contentTable,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              acc.accountType ?? '',
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
            IconButton(
              color: Colors.redAccent,
              icon: Icon(
                Icons.edit,
                color: Colors.orangeAccent,
                size: 19.0,
              ),
              onPressed: () {
                _pushEditAccountScreen(acc);
              },
            ),
            IconButton(
              color: Colors.redAccent,
              icon: Icon(
                Icons.delete,
                color: Colors.redAccent,
                size: 19.0,
              ),
              onPressed: () {
                _deleteAccount(acc.username);
              },
            ),
            IconButton(
              color: Colors.redAccent,
              icon: Icon(
                Icons.refresh,
                color: Colors.greenAccent,
                size: 19.0,
              ),
              onPressed: () {
                _resetAccount(acc.username);
              },
            ),
            IconButton(
              color: Colors.redAccent,
              icon: Icon(
                Icons.info,
                color: Colors.blueAccent,
                size: 19.0,
              ),
              onPressed: () {
                _pushDetailsAccountScreen(acc);
              },
            ),
          ],
        ),
      )
    ]);
  }

  void _deleteAccount(String username) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm', style: theme.titleStyle),
            content: Text('Do you want to delete this account: ' + username + '?',
                style: theme.contentStyle),
            actions: <Widget>[
              FlatButton(
                  child: Text('Ok', style: theme.okButtonStyle),
                  onPressed: () async {
                    /* Pop screens */
                    Navigator.of(context).pop();
                    if (!(await Controller.instance.isAccExists(username))) {
                      if (await Controller.instance.deleteAcc(username)) {
                        Controller.instance.deleteAccountToLocal(username);
                        setState(() {
                          accs = Controller.instance.listAccount;
                        });
                        successDialog(this.context,
                            'Delete this account: ' + username + ' success!');
                      } else
                        errorDialog(
                            this.context,
                            'Delete this account: ' +
                                username +
                                ' failed.' +
                                '\nPlease try again!');
                    } else
                      errorDialog(
                          this.context,
                          'Can\'t delete this account: ' +
                              username +
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

  void _resetAccount(String username) {
    // only reset password
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm', style: theme.titleStyle),
            content: Text('Do you want to reset this account: ' + username + '?',
                style: theme.contentStyle),
            actions: <Widget>[
              FlatButton(
                  child: Text('Ok', style: theme.okButtonStyle),
                  onPressed: () async {
                    /* Pop screens */
                    Navigator.of(context).pop();
                    if (await Controller.instance.resetAcc(username, username)) {
                      successDialog(
                          this.context, 'Reset this account: ' + username + ' success!');
                    } else
                      errorDialog(
                          this.context,
                          'Reset this account: ' +
                              username +
                              ' failed.' +
                              '\nPlease try again!');
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

  void _pushAddAccountScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Add Account',
              style: TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),
            ),
            iconTheme: IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: AddAccountScreen(),
        );
      }),
    ).then((value) {
      setState(() {
        accs = Controller.instance.listAccount;
      });
    });
  }

  void _pushEditAccountScreen(Account acc) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Account',
              style: TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),
            ),
            iconTheme: IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: EditAccountScreen(acc: acc),
        );
      }),
    ).then((value) {
      setState(() {
        accs = Controller.instance.listAccount;
      });
    });
  }

  void _pushDetailsAccountScreen(Account acc) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Details Account',
              style: TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),
            ),
            iconTheme: IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: AccountDetailScreen(account: acc),
        );
      }),
    );
  }
}
