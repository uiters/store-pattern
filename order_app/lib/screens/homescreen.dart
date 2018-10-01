import 'package:flutter/material.dart';
import './../UI/theme.dart';
import './menuscreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: fontColorLight.withOpacity(0.2))),
        margin: EdgeInsets.all(5.0),
        child: new ListView.builder(
          itemExtent: 100.0,
          itemCount: 20,
          itemBuilder: (_, index) => _buildTableRow(context)),
    );
  }
  
  Widget _buildTableRow(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pushMenuScreen();
      },
      child: new Container(
        child: new Row(
          children: <Widget>[
            new Expanded(child: _buildTable(context)),
            new Expanded(child: _buildTable(context)),
            new Expanded(child: _buildTable(context)),
          ],
        ),
      ),
    );
  }

  void _pushMenuScreen() {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
            appBar: new AppBar(
              title: new Text('Select Foods',style: new TextStyle(color: accentColor, fontFamily: 'Dosis'),),
              iconTheme: new IconThemeData(color: accentColor),
              centerTitle: true,
            ),
            body: new MenuScreen(),
        );
      }),
    );
  }
  
  Widget _buildTable(BuildContext context) {
    return new Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: new Card(
        color: primaryColor,
        child: new Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Icon(Icons.people, size: 20.0,),
            ),
            new Expanded(child: new Container()),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: new Text(
                '01',
                style: const TextStyle(
                    color: fontColor, fontFamily: 'Dosis', fontSize: 20.0
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
