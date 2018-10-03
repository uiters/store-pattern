import 'package:flutter/material.dart';
import './../UI/theme.dart';

class MainPage extends StatefulWidget {
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _screenNumber = 0;
  Drawer _buildDrawer(BuildContext context) {
    return new Drawer(
      child: new ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          new DrawerHeader(
              child: new Container(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Image.asset(
                      'assets/images/menu5.png',
                      width: 110.0,
                      height: 110.0,
                      fit: BoxFit.cover,
                    ),
                    new Text(
                      'Admin App',
                      style: new TextStyle(
                          color: accentColor,
                          fontFamily: 'Dosis',
                          fontSize: 21.0),
                    ),
                  ],
                ),
              ),
              decoration: new BoxDecoration(color: primaryColor)),
          new ListTile(
            leading: new Icon(Icons.monetization_on, color: fontColorLight, size: 19.0,),
            title: new Text('Report', style: new TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),),
            onTap: () {
              setState(() {
                this._screenNumber = 0;
              });
              Navigator.pop(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.album, color: fontColorLight, size: 19.0,),
            title: new Text('Table', style: new TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),),
            onTap: () {
              setState(() {
                this._screenNumber = 1;
              });
              Navigator.pop(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.fastfood, color: fontColorLight, size: 19.0,),
            title: new Text('Food', style: new TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),),
            onTap: () {
              setState(() {
                this._screenNumber = 2;
              });
              Navigator.pop(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.category, color: fontColorLight, size: 19.0,),
            title: new Text('Categogry', style: new TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),),
            onTap: () {
              setState(() {
                this._screenNumber = 3;
              });
              Navigator.pop(context);
            },
          ),


          new Divider(
            indent: 16.0,
          ),
          new ListTile(
            leading: new Icon(Icons.info, color: fontColorLight, size: 19.0,),
            title: new Text('About', style: new TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),),
            onTap: () {
              setState(() {
                this._screenNumber = 4;
              });
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
  Widget _buildScreen(BuildContext context) {
    switch (this._screenNumber) {
      case 0: return new Text('ndc07');
      default: return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: new Scaffold(
            appBar: new AppBar(
              title: new Text(
                'REPORT',
                style: new TextStyle(color: accentColor, fontFamily: 'Dosis'),
              ),
              iconTheme: new IconThemeData(color: accentColor),
              centerTitle: true,
            ),
            body: _buildScreen(context),
            drawer: this._buildDrawer(context)));
  }
}
