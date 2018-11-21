import 'package:flutter/material.dart';

import './home.view.dart';
import './history.view.dart';
import './profile.view.dart';

import './../Models/login.model.dart';

import './../Constants/theme.dart';

class MainPage extends StatefulWidget {
  MainPage({key, this.context, this.account}) : super(key: key);

  final BuildContext context;
  final Account account;

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
                    new Container(
                      width: 90.0,
                      height: 90.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new MemoryImage(
                            widget.account.image,
                          )
                        )
                      )
                    ),
                    new Text(
                      widget.account.displayName,
                      overflow: TextOverflow.ellipsis,
                      style: new TextStyle(
                          color: accentColor,
                          fontFamily: 'Dosis',
                          fontSize: 20.0),
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
            leading: new Icon(Icons.person, color: fontColorLight, size: 19.0,),
            title: new Text('My Profile', style: new TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),),
            onTap: () {
              setState(() {
                this._screenNumber = 2;
                this._screenName = 'MY PROFILE';
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
            leading: new Icon(Icons.exit_to_app, color: fontColorLight, size: 19.0,),
            title: new Text('Logout', style: new TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(widget.context);
            },
          )
        ],
      ),
    );
  }
  Widget _buildScreen(BuildContext context) {
    switch (this._screenNumber) {
      case 0: return new HomeScreen(account: widget.account,);
      case 1: return new HistoryScreen();
      case 2: return new ProfileScreen(account: widget.account,);
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
        ),
        body: _buildScreen(context),
        drawer: this._buildDrawer(context))
      );
  }

}
