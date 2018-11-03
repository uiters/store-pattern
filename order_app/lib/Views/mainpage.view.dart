import 'package:flutter/material.dart';
import './../Constants/theme.dart';
import './home.view.dart';

class MainPage extends StatefulWidget {
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _screenNumber = 0;
  String _screenName = 'HOME';

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
                      'assets/images/menu1.png',
                      width: 110.0,
                      height: 110.0,
                      fit: BoxFit.cover,
                    ),
                    new Text(
                      'Order App',
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
            leading: new Icon(Icons.home, color: fontColorLight, size: 19.0,),
            title: new Text(
              'Home', 
              style: new TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),),
            onTap: () {
              setState(() {
                this._screenNumber = 0;
                this._screenName = 'HOME';
              });
              Navigator.pop(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.history, color: fontColorLight, size: 19.0,),
            title: new Text('History', style: new TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),),
            onTap: () {
              setState(() {
                this._screenNumber = 1;
                this._screenName = 'HISTORY';
              });
              Navigator.pop(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.notifications, color: fontColorLight, size: 19.0,),
            title: new Text('Notifications', style: new TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),),
            onTap: () {
              setState(() {
                this._screenNumber = 2;
                this._screenName = 'NOTIFICATIONS';
              });
              Navigator.pop(context);
            },
          ),


          new Divider(
            indent: 16.0,
          ),
          new ListTile(
            leading: new Icon(Icons.settings, color: fontColorLight, size: 19.0,),
            title: new Text('Settings', style: new TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),),
            onTap: () {
              setState(() {
                this._screenNumber = 3;
                this._screenName = 'SETTING';
              });
              Navigator.pop(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.info, color: fontColorLight, size: 19.0,),
            title: new Text('About', style: new TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),),
            onTap: () {
              setState(() {
                this._screenNumber = 4;
                this._screenName = 'ABOUT';
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
      case 0: return new HomeScreen();
      default: return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: new Scaffold(
            appBar: new AppBar(
              title: new Text(
                _screenName,
                style: new TextStyle(color: accentColor, fontFamily: 'Dosis'),
              ),
              iconTheme: new IconThemeData(color: accentColor),
              centerTitle: true,
              actions: <Widget>[
                new IconButton(
                    icon: new Icon(
                        Icons.notifications,
                        size: 22.0,
                        color: accentColor),
                    onPressed: () {
                      _pushCartScreen();
                    }
                    ),
              ],
            ),
            body: _buildScreen(context),
            drawer: this._buildDrawer(context)));
  }

  void _pushCartScreen() {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Cart',
              style: new TextStyle(color: accentColor, fontFamily: 'Dosis'),),
            iconTheme: new IconThemeData(color: accentColor),
            centerTitle: true,
          ),
          body: new Text('Notifications'),
//          floatingActionButton: new FloatingActionButton(
//            onPressed: () {},
//            child: new Icon(Icons.payment),
//            tooltip: 'Payment',
//            backgroundColor: fontColor,
//          ),
        );
      }),
    );
  }
}
