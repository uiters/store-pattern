import 'package:flutter/material.dart';

import './../Models/login.model.dart';

import './profile.view.dart';
import './category.view.dart';
import './table.view.dart';
import './accountType.view..dart';
import './food.view.dart';

import './../Constants/theme.dart';

class MainPage extends StatefulWidget {
  MainPage({key, this.context, this.account}) : super(key: key);

  final BuildContext context;
  final Account account;

  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _screenNumber = 0;
  String _screenName = 'DASHBOARD';

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
            decoration: new BoxDecoration(color: primaryColor)
          ),
          new ListTile(
            leading: new Icon(Icons.dashboard, color: fontColorLight, size: 19.0,),
            title: new Text(
              'Dashboard', 
              style: new TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),),
            onTap: () {
              setState(() {
                this._screenNumber = 0;
                this._screenName = 'DASHBOARD';
              });
              Navigator.pop(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.fastfood, color: fontColorLight, size: 19.0,),
            title: new Text('Food', style: new TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),),
            onTap: () {
              setState(() {
                this._screenNumber = 1;
                this._screenName = 'FOOD';
              });
              Navigator.pop(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.category, color: fontColorLight, size: 19.0,),
            title: new Text('Food Category', style: new TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),),
            onTap: () {
              setState(() {
                this._screenNumber = 2;
                this._screenName = 'FOOD CATEGORY';
              });
              Navigator.pop(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.table_chart, color: fontColorLight, size: 19.0,),
            title: new Text('Table', style: new TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),),
            onTap: () {
              setState(() {
                this._screenNumber = 3;
                this._screenName = 'TABLE';
              });
              Navigator.pop(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.account_circle, color: fontColorLight, size: 19.0,),
            title: new Text('Account', style: new TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),),
            onTap: () {
              setState(() {
                this._screenNumber = 4;
                this._screenName = 'ACCOUNT';
              });
              Navigator.pop(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.supervisor_account, color: fontColorLight, size: 19.0,),
            title: new Text('Account Type', style: new TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),),
            onTap: () {
              setState(() {
                this._screenNumber = 5;
                this._screenName = 'ACCOUNT TYPE';
              });
              Navigator.pop(context);
            },
          ),

          new Divider(
            indent: 16.0,
          ),
          
          new ListTile(
            leading: new Icon(Icons.person, color: fontColorLight, size: 19.0,),
            title: new Text('My Profile', style: new TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),),
            onTap: () {
              setState(() {
                this._screenNumber = 6;
                this._screenName = 'MY PROFILE';
              });
              Navigator.pop(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.settings, color: fontColorLight, size: 19.0,),
            title: new Text('Settings', style: new TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),),
            onTap: () {
              setState(() {
                this._screenNumber = 7;
                this._screenName = 'SETTINGS';
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
          ),
          new ListTile(
            leading: new Icon(Icons.info, color: fontColorLight, size: 19.0,),
            title: new Text('About', style: new TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),),
            onTap: () {
              setState(() {
                this._screenNumber = 8;
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
      case 1: return new FoodScreen();
      case 2: return new CategoryScreen();
      case 3: return new TableScreen();
      case 5: return new AccountTypeScreen();
      case 6: return new ProfileScreen(account: widget.account,);
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
        resizeToAvoidBottomPadding: false,
        drawer: this._buildDrawer(context)
      )
    );
  }
}
