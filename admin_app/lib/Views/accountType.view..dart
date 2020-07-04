import 'package:flutter/material.dart';
import 'package:admin_app/utils/log.dart';

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
              _pushAddAccountTypeScreen();
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
                      accTypes =
                          Controller.instance.searchAccTypes(_keywordController.text);
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

    Widget table = FutureBuilder<List<AccountType>>(
      future: accTypes,
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
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Table(
                  defaultColumnWidth: FlexColumnWidth(4.0),
                  columnWidths: {0: FlexColumnWidth(1.0), 2: FlexColumnWidth(5.0)},
                  border: TableBorder.all(width: 1.0, color: theme.fontColorLight),
                  children: _buildListRow(accTypes)),
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

  TableRow _buildTableData(AccountType accType) {
    return TableRow(children: [
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              accType.id.toString(),
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
              accType.name,
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
                _pushEditAccountTypeScreen(accType);
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
            title: Text('Confirm', style: theme.titleStyle),
            content: Text(
                'Do you want to delete this account type: ' + accType.name + '?',
                style: theme.contentStyle),
            actions: <Widget>[
              FlatButton(
                  child: Text('Ok', style: theme.okButtonStyle),
                  onPressed: () async {
                    /* Pop screens */
                    Navigator.of(context).pop();
                    if (!(await Controller.instance.isAccTypeExists(accType.id))) {
                      if (await Controller.instance.deleteAccType(accType.id)) {
                        Controller.instance.deleteAccTypeToLocal(accType.id);
                        setState(() {
                          accTypes = Controller.instance.accTypes;
                        });
                        successDialog(this.context,
                            'Delete this account type: ' + accType.name + ' success!');
                      } else
                        errorDialog(
                            this.context,
                            'Delete this account type: ' +
                                accType.name +
                                ' failed.' +
                                '\nPlease try again!');
                    } else
                      errorDialog(
                          this.context,
                          'Can\'t delete this account type: ' +
                              accType.name +
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

  void _pushAddAccountTypeScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Add Account Type',
              style: TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),
            ),
            iconTheme: IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: AddAccountTypeScreen(),
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
      MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Account Type',
              style: TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),
            ),
            iconTheme: IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: EditAccountTypeScreen(accType: accType),
        );
      }),
    ).then((value) {
      setState(() {
        accTypes = Controller.instance.accTypes;
      });
    });
  }
}
