import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import './../Controllers/report.controller.dart';
import './../Models/report.model.dart';

import './../Constants/theme.dart' as theme;
import 'package:charts_flutter/flutter.dart' as charts;

class DashBoardScreen extends StatefulWidget {
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  Future<List<Report>> reports = Controller.instance.reportsWeek;
  Future<Report> report = Controller.instance.reportToday;
  
  TextStyle _itemStyle =
      TextStyle(color: theme.fontColor, fontFamily: 'Dosis', fontSize: 16.0);

  TextStyle _itemStyle2 = TextStyle(
      color: theme.accentColor,
      fontFamily: 'Dosis',
      fontSize: 34.0,
      fontWeight: FontWeight.w600);

  TextStyle _itemStytle3 = TextStyle(
      color: theme.accentColor,
      fontFamily: 'Dosis',
      fontWeight: FontWeight.w400,
      fontSize: 14.0);

  static final List<String> chartDropdownItems = [
    'Last 7 days',
    'Months',
    'Years'
  ];
  String totalMoneyToday = '';
  String totalMoney = '';
  String currentItem = chartDropdownItems[0];
  DateFormat format = new DateFormat.Md();
  @override
  Widget build(BuildContext context) {
    Widget boxToday = _buildTile(Padding(
      padding: const EdgeInsets.all(24.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Today', style: _itemStyle),
              new FutureBuilder(
                future: report,
                builder: (context, snapshot) {
                  if(snapshot.hasError) print(snapshot.error);
                  if(snapshot.hasData) {
                     Report rp = snapshot.data;
                     totalMoneyToday = '\$' + _roundMoney(rp.totalPrice);
                  }
                  return Text('$totalMoneyToday', style: _itemStyle2);
                },
              )
            ],
          ),
          new Material(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(24.0),
            child: new Center(
              child: new Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  Icons.timeline,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
            ),
          )
        ],
      ),
    ));

    Widget boxChart = _buildTile(Padding(
      padding: const EdgeInsets.all(24.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text('Revenue', style: _itemStyle),
                      new FutureBuilder(
                        future: reports,
                        builder: (context, snapshot) {
                          if(snapshot.hasError) print(snapshot.error);
                          if(snapshot.hasData) 
                            _buildTotalMoney(snapshot.data);
                          return new Text('$totalMoney', style: _itemStyle2);
                        },
                      )
                    ]),
                new DropdownButton(
                    isDense: true,
                    value: currentItem,
                    onChanged: (String value) => setState(() {
                          currentItem = value;
                          for (var i = 0; i < chartDropdownItems.length; ++i) {
                            if (value == chartDropdownItems[i]) {
                              _reloadData(i);
                            }
                          }
                        }),
                    items: chartDropdownItems.map((String title) {
                      return DropdownMenuItem(
                        value: title,
                        child: Text(title, style: _itemStytle3),
                      );
                    }).toList()),
              ]),
          new Padding(padding: EdgeInsets.only(bottom: 2.0)),
          new SizedBox(
            child: new FutureBuilder<List<Report>>(
              future: reports,
              builder: (context, snapShot) {
                if(snapShot.hasError) print(snapShot.error);
                if(snapShot.hasData)
                    return _buildChart(snapShot.data);
                else
                  return new Center(child: new CircularProgressIndicator(),);
              },
            ),
            height: 250,
          )
        ],
      ),
    ));
    return Container(
      padding: EdgeInsets.only(left: 12.0, right: 12.0),
      child: new ListView(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          new Column(
            children: <Widget>[
              SizedBox(height: 12.0),
              boxToday,
              SizedBox(height: 12.0),
              boxChart,//new charts.LineChart(seriesList, animate: false,)
            ],
          ),
        ],
      )  
    );
  }

  Widget _buildTile(Widget child) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: child);
  }

  Widget _buildChart(List<Report> rp) {
    return new charts.BarChart(
      _parseSeries(rp),
      animate: true,
      //dateTimeFactory: const charts.LocalDateTimeFactory(),
      //defaultRenderer: new charts.LineRendererConfig(includePoints: true, includeArea: true),
    );
  }

  void _buildTotalMoney(List<Report> rp) {

    double sum = 0;
    for (var i = 0; i < rp.length; ++i) {
      sum += rp[i].totalPrice;
    }

    totalMoney = '\$' + _roundMoney(sum);
  }

  void _reloadData(int id) {

    report = Controller.instance.reportToday;


    switch(id) {
      case 0: 
        reports = Controller.instance.reportsWeek;
        format= new DateFormat.Md();
        break;
      case 1:
        reports = Controller.instance.reportsMonth;
        format= new DateFormat.yMMM();
      break;
      default:
        reports = Controller.instance.reportsYear;
        format= new DateFormat.y();
      break;
    }

  }

  List<charts.Series<Report, String>> _parseSeries(List<Report> reports) {
    return [
      new charts.Series<Report, String>(
        id: 'Report',
        colorFn: (_, __) =>charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Report rp, index) => format.format(rp.day),
        measureFn: (Report rp, index) => rp.totalPrice,
        data: reports
      ),
    ];
  }
  String _roundMoney(double money) {
    int round = money.round();
    if (round < 1000)
      return round.toString();
    if (round < 1000000)
      return (money / 1000).round().toString() + 'K';
    if (round < 1000000000)
      return (money / 1000000).round().toString() + 'M';
    else
      return (money / 1000000000).round().toString() + 'B';
  }
}
