import 'package:flutter/material.dart';

import './../Constants/theme.dart';
import './../Models/login.model.dart';
import './history.view.dart';
import './home.view.dart';
import './profile.view.dart';

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
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                        width: 90.0,
                        height: 90.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: widget.account.image.isEmpty
                                    ? AssetImage(
                                        'assets/images/account.png',
                                      )
                                    : MemoryImage(
                                        widget.account.image,
                                      )))),
                    Text(
                      widget.account.displayName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: accentColor, fontFamily: 'Dosis', fontSize: 20.0),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(color: primaryColor)),
          ListTile(
            leading: Icon(
              Icons.home,
              color: fontColorLight,
              size: 19.0,
            ),
            title: Text(
              'Home',
              style: TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),
            ),
            onTap: () {
              setState(() {
                this._screenNumber = 0;
                this._screenName = 'HOME';
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.history,
              color: fontColorLight,
              size: 19.0,
            ),
            title: Text(
              'History',
              style: TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),
            ),
            onTap: () {
              setState(() {
                this._screenNumber = 1;
                this._screenName = 'HISTORY';
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: fontColorLight,
              size: 19.0,
            ),
            title: Text(
              'My Profile',
              style: TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),
            ),
            onTap: () {
              setState(() {
                this._screenNumber = 2;
                this._screenName = 'MY PROFILE';
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: fontColorLight,
              size: 19.0,
            ),
            title: Text(
              'Logout',
              style: TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(widget.context);
            },
          ),
          Divider(
            indent: 16.0,
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: fontColorLight,
              size: 19.0,
            ),
            title: Text(
              'Settings',
              style: TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),
            ),
            onTap: () {
              setState(() {
                this._screenNumber = 3;
                this._screenName = 'SETTINGS';
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: fontColorLight,
              size: 19.0,
            ),
            title: Text(
              'About',
              style: TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),
            ),
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
      case 0:
        return HomeScreen(
          account: widget.account,
        );
      case 1:
        return HistoryScreen();
      case 2:
        return ProfileScreen(
          account: widget.account,
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                _screenName,
                style: TextStyle(color: accentColor, fontFamily: 'Dosis'),
              ),
              iconTheme: IconThemeData(color: accentColor),
              centerTitle: true,
              actions: <Widget>[
                _screenNumber == 0
                    ? IconButton(
                        icon: Icon(Icons.refresh),
                        color: accentColor,
                        onPressed: () {
                          setState(() {});
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.refresh),
                        color: primaryColor,
                        onPressed: () {
                          setState(() {});
                        },
                      )
              ],
            ),
            resizeToAvoidBottomPadding: false,
            body: _buildScreen(context),
            drawer: this._buildDrawer(context)));
  }
}
