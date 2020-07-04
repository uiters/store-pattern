import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './../Models/bill.model.dart';

import './billDetail.view.dart';

import './../Controllers/bill.controller.dart';

import './../Constants/dialog.dart';
import './../Constants/theme.dart' as theme;

class BillScreen extends StatefulWidget {
  _BillScreenState createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  Future<List<Bill>> bills = Controller.instance.bills;
  TextEditingController _keywordController = TextEditingController();
  var format = DateFormat('MM/dd/yyyy \nhh:mm:ss');
  static var formatDate = DateFormat.yMd();
  static DateTime now = DateTime.now();
  String txbDayStart = formatDate.format(now);
  String txbDayEnd = formatDate.format(now);

  TextStyle _itemStyleDay = TextStyle(
    color: theme.accentColor,
    fontFamily: 'Dosis',
    fontSize: 16.0,
  );

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Container(width: 30.0,),
          Flexible(
              child: TextField(
                  controller: _keywordController,
                  onChanged: (keyword) {
                    setState(() {
                      bills = Controller.instance.searchFoods(keyword,
                          formatDate.parse(txbDayStart), formatDate.parse(txbDayEnd));
                    });
                  },
                  onSubmitted: null,
                  style: _itemStyle,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Enter your table...',
                    hintStyle: _itemStyle,
                  ))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('$txbDayStart', style: _itemStyleDay),
              Text(
                '-',
                style: _itemStyleDay,
              ),
              Text(
                '$txbDayEnd',
                style: _itemStyleDay,
              ),
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.orangeAccent,
                  size: 19.0,
                ),
                onPressed: () {
                  _selectDate();
                },
              )
            ],
          )
        ],
      ),
    );

    Widget table = FutureBuilder<List<Bill>>(
      future: bills,
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

  List<TableRow> _buildListRow(List<Bill> foods) {
    List<TableRow> listRow = [_buildTableHead()];
    for (var item in foods) {
      listRow.add(_buildTableData(item));
    }
    return listRow;
  }

  Widget _buildTable(List<Bill> foods) {
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
                  columnWidths:
                      MediaQuery.of(context).orientation == Orientation.landscape
                          ? {
                              0: FlexColumnWidth(0.5),
                              1: FlexColumnWidth(1.0),
                              2: FlexColumnWidth(1.3),
                              3: FlexColumnWidth(1.3),
                              4: FlexColumnWidth(0.9),
                              5: FlexColumnWidth(1.0),
                              6: FlexColumnWidth(1.0),
                              7: FlexColumnWidth(0.9),
                              8: FlexColumnWidth(1.7),
                            }
                          : {
                              0: FlexColumnWidth(0.5),
                              1: FlexColumnWidth(1.0),
                              2: FlexColumnWidth(1.5),
                              3: FlexColumnWidth(1.0),
                              4: FlexColumnWidth(1.0),
                            },
                  border: TableBorder.all(width: 1.0, color: theme.fontColorLight),
                  children: _buildListRow(foods)),
            ],
          )),
    );
  }

  TableRow _buildTableHead() {
    List<TableCell> table = [
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
              'Table',
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
              'Checkout',
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
              'Prices',
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
              'Status',
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
    ];
    var checkin = TableCell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Checkin',
            style: theme.headTable,
          ),
        ],
      ),
    );
    var discount = TableCell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Discount',
            style: theme.headTable,
          ),
        ],
      ),
    );
    var staff = TableCell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Staff',
            style: theme.headTable,
          ),
        ],
      ),
    );
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      table.insert(table.length - 4, checkin);
      table.insert(table.length - 2, discount);
      table.insert(table.length - 2, staff);
    }
    return TableRow(children: table);
  }

  TableRow _buildTableData(Bill bill) {
    List<TableCell> tableCell = [
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              bill.id.toString(),
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
              bill.nameTable,
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
              format.format(bill.dateCheckOut),
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
              '\$${bill.totalPrice}',
              style: theme.contentTable,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      TableCell(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text(
            '${bill.status}',
            style: theme.contentTable,
            overflow: TextOverflow.ellipsis,
          ),
        ]),
      ),
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              color: Colors.redAccent,
              icon: Icon(
                Icons.delete,
                color: Colors.redAccent,
                size: 19.0,
              ),
              onPressed: () {
                _deleteBill(bill);
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
                _pushDetailsBillScreen(bill);
              },
            ),
          ],
        ),
      )
    ];
    var checkin = TableCell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            format.format(bill.dateCheckIn),
            style: theme.contentTable,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
    var discount = TableCell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${bill.discount}',
            style: theme.contentTable,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );

    var staff = TableCell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${bill.userName}',
            style: theme.contentTable,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      tableCell.insert(tableCell.length - 4, checkin);
      tableCell.insert(tableCell.length - 2, discount);
      tableCell.insert(tableCell.length - 2, staff);
    }
    return TableRow(children: tableCell);
  }

  Future _selectDate() async {
    DateTime pickedStart = await showDatePicker(
      context: context,
      initialDate: formatDate.parse(txbDayStart),
      firstDate: DateTime(1975),
      lastDate: DateTime.now(),
    );
    if (pickedStart != null) {
      setState(() => txbDayStart = formatDate.format(pickedStart));
      DateTime pickedEnd = await showDatePicker(
        context: context,
        initialDate: formatDate.parse(txbDayEnd),
        firstDate: formatDate.parse(txbDayStart),
        lastDate: DateTime.now(),
      );
      if (pickedEnd != null) setState(() => txbDayEnd = formatDate.format(pickedEnd));
    }
    setState(() {
      bills = Controller.instance.searchFoods(_keywordController.text,
          formatDate.parse(txbDayStart), formatDate.parse(txbDayEnd));
    });
  }

  void _deleteBill(Bill bill) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm', style: theme.titleStyle),
            content: Text('Do you want to delete this bill: ${bill.id}?',
                style: theme.contentStyle),
            actions: <Widget>[
              FlatButton(
                  child: Text('Ok', style: theme.okButtonStyle),
                  onPressed: () async {
                    /* Pop screens */
                    Navigator.of(context).pop();
                    if (await Controller.instance.deleteBill(bill.id)) {
                      Controller.instance.deleteLocal(bill.id);
                      setState(() {
                        bills = Controller.instance.searchFoods(_keywordController.text,
                            formatDate.parse(txbDayStart), formatDate.parse(txbDayEnd));
                      });
                      successDialog(
                          this.context, 'Delete this bill: ${bill.id} success!');
                    } else
                      errorDialog(this.context,
                          'Delete this bill: ${bill.id} failed.' + '\nPlease try again!');
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

  void _pushDetailsBillScreen(Bill bill) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                'Bill Detail',
                style: TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),
              ),
              iconTheme: IconThemeData(color: theme.accentColor),
              centerTitle: true,
            ),
            body: BillDetailScreen(
              bill: bill,
            ));
      }),
    );
  }
}
