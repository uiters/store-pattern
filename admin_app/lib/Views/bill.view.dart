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
  TextEditingController _keywordController = new TextEditingController();
  var format = DateFormat('MM/dd/yy hh:mm');
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
          new Container(width: 30.0,),
          new Flexible(
            child: new TextField(
              controller: _keywordController,
              onChanged: (keyword) {
                setState(() {
                  bills = Controller.instance.searchFoods(keyword);
                });
              },
              onSubmitted: null,
              style: _itemStyle,
              decoration: InputDecoration.collapsed(
                  hintText: 'Enter your bill...',
                  hintStyle: _itemStyle,
              )
            )
          ),
        ],
      ),
    );

    Widget table = new FutureBuilder<List<Bill>>(
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
        children: <Widget>[
          controls,
          table
        ],
      ),
    );
  }

  List<TableRow> _buildListRow(List<Bill> foods) {
    List<TableRow> listRow = [
      _buildTableHead()
    ];
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
        child: new ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              new Table(
                defaultColumnWidth: FlexColumnWidth(2.0),
                columnWidths: MediaQuery.of(context).orientation == Orientation.landscape ? {
                  0: FlexColumnWidth(0.5),
                  1: FlexColumnWidth(1.0),
                  2: FlexColumnWidth(1.6),
                  3: FlexColumnWidth(1.6),
                  4: FlexColumnWidth(1.0),
                  5: FlexColumnWidth(1.0),
                  6: FlexColumnWidth(0.8),
                  7: FlexColumnWidth(0.9),
                  8: FlexColumnWidth(1.7),
                } : {
                  0: FlexColumnWidth(0.5),
                  1: FlexColumnWidth(1.0),
                  2: FlexColumnWidth(1.5),
                  3: FlexColumnWidth(1.0),
                  //4: FlexColumnWidth(1.0),
                },
                border: TableBorder.all(width: 1.0, color: theme.fontColorLight),
                children: _buildListRow(foods)
              ),
            ],
          )
      ),
    );
  }

  TableRow _buildTableHead() {

    List<TableCell> table = [
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
            new Text('Table', style: theme.headTable,),
          ],
        ),
      ),
      new TableCell(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('Checkout', style: theme.headTable,),
          ],
        ),
      ),
      new TableCell(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('Prices', style: theme.headTable,),
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
    ];
    var checkin = new TableCell(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text('Checkin', style: theme.headTable,),
        ],
      ),
    );
    var discount =  new TableCell(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('Discount', style: theme.headTable,),
          ],
        ),
      );
    var staff = new TableCell(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('Staff', style: theme.headTable,),
          ],
        ),
      );
    var status = new TableCell(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('Status', style: theme.headTable,),
          ],
        ),
      );
      if(MediaQuery.of(context).orientation == Orientation.landscape) {
        table.insert(table.length - 3, checkin);
        table.insert(table.length - 2, discount);
        table.insert(table.length - 1, staff);
        table.insert(table.length - 1, status);
      }
    return new TableRow(
      children: table
    );
  }

  TableRow _buildTableData(Bill bill) {
    List<TableCell> tableCell = [
      new TableCell(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(bill.id.toString(), style: theme.contentTable,),
          ],
        ),
      ),
      new TableCell(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(bill.nameTable, style: theme.contentTable, overflow: TextOverflow.ellipsis,),
          ],
        ),
      ),
      new TableCell(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(format.format(bill.dateCheckOut), style: theme.contentTable, overflow: TextOverflow.ellipsis,),
          ],
        ),
      ),
      new TableCell(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('\$${bill.totalPrice}', style: theme.contentTable, overflow: TextOverflow.ellipsis,),
          ],
        ),
      ),
      new TableCell(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new IconButton(
              color: Colors.redAccent,
              icon: new Icon(Icons.delete, color: Colors.redAccent, size: 19.0,),
              onPressed: () {
                _deleteBill(bill);
              },
            ),
            new IconButton(
              color: Colors.redAccent,
              icon: new Icon(Icons.info, color: Colors.blueAccent, size: 19.0,),
              onPressed: () {
                _pushDetailsBillScreen(bill);
              },
            ),
          ],
        ),
      )
    ];
    var checkin = new TableCell(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(format.format(bill.dateCheckIn), style: theme.contentTable, overflow: TextOverflow.ellipsis,),
        ],
      ),
    );
    var discount = new TableCell(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text('${bill.discount}', style: theme.contentTable, overflow: TextOverflow.ellipsis,),
        ],
      ),
    );

    var staff = new TableCell(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text('${bill.userName}', style: theme.contentTable, overflow: TextOverflow.ellipsis,),
        ],
      ),
    );
    var status = new TableCell(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text('${bill.status}', style: theme.contentTable, overflow: TextOverflow.ellipsis,),
        ],
      ),
    );
    if(MediaQuery.of(context).orientation == Orientation.landscape) {
        tableCell.insert(tableCell.length - 3, checkin);
        tableCell.insert(tableCell.length - 2, discount);
        tableCell.insert(tableCell.length - 1, staff);
        tableCell.insert(tableCell.length - 1, status);
      }
    return new TableRow(
      children: tableCell
    );
  }

  void _deleteBill(Bill bill) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            'Confirm',
            style: theme.titleStyle
          ),
          content: new Text(
            'Do you want to delete this bill: ${bill.id}?',
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
                  if (await Controller.instance.deleteBill(bill.id)) {
                    Controller.instance.deleteLocal(bill.id);
                    setState(() {
                      bills = Controller.instance.bills;
                    });
                    successDialog(this.context, 'Delete this bill: ${bill.id} success!');
                  }
                  else errorDialog(this.context, 'Delete this bill: ${bill.id} failed.' + '\nPlease try again!');
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

  void _pushDetailsBillScreen(Bill bill) {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text(
              'Bill Detail',
              style: new TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),),
            iconTheme: new IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: new BillDetailScreen(bill: bill,)
        );
      }),
    );
  }
}