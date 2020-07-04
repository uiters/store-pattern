import 'package:flutter/material.dart';
import 'package:admin_app/Views/table.view.dart';

import './../Constants/theme.dart';
import './../Models/login.model.dart';
import './account.view.dart';
import './accountType.view..dart';
import './bill.view.dart';
import './category.view.dart';
import './dashboard.view.dart';
import './food.view.dart';
import './profile.view.dart';

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
                      style: TextStyle(
                          color: accentColor, fontFamily: 'Dosis', fontSize: 20.0),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(color: primaryColor)),
          ListTile(
            leading: Icon(
              Icons.dashboard,
              color: fontColorLight,
              size: 19.0,
            ),
            title: Text(
              'Dashboard',
              style: TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),
            ),
            onTap: () {
              setState(() {
                this._screenNumber = 0;
                this._screenName = 'DASHBOARD';
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.monetization_on,
              color: fontColorLight,
              size: 19.0,
            ),
            title: Text(
              'Bill',
              style: TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),
            ),
            onTap: () {
              setState(() {
                this._screenNumber = 1;
                this._screenName = 'BILL';
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.fastfood,
              color: fontColorLight,
              size: 19.0,
            ),
            title: Text(
              'Food',
              style: TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),
            ),
            onTap: () {
              setState(() {
                this._screenNumber = 2;
                this._screenName = 'FOOD';
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.category,
              color: fontColorLight,
              size: 19.0,
            ),
            title: Text(
              'Food Category',
              style: TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),
            ),
            onTap: () {
              setState(() {
                this._screenNumber = 3;
                this._screenName = 'FOOD CATEGORY';
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.table_chart,
              color: fontColorLight,
              size: 19.0,
            ),
            title: Text(
              'Table',
              style: TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),
            ),
            onTap: () {
              setState(() {
                this._screenNumber = 4;
                this._screenName = 'TABLE';
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: fontColorLight,
              size: 19.0,
            ),
            title: Text(
              'Account',
              style: TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),
            ),
            onTap: () {
              setState(() {
                this._screenNumber = 5;
                this._screenName = 'ACCOUNT';
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.supervisor_account,
              color: fontColorLight,
              size: 19.0,
            ),
            title: Text(
              'Account Type',
              style: TextStyle(fontFamily: 'Dosis', color: fontColor, fontSize: 16.0),
            ),
            onTap: () {
              setState(() {
                this._screenNumber = 6;
                this._screenName = 'ACCOUNT TYPE';
              });
              Navigator.pop(context);
            },
          ),
          Divider(
            indent: 16.0,
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
                this._screenNumber = 7;
                this._screenName = 'MY PROFILE';
              });
              Navigator.pop(context);
            },
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
                this._screenNumber = 8;
                this._screenName = 'SETTINGS';
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
                this._screenNumber = 9;
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
        return DashBoardScreen();
      case 1:
        return BillScreen();
      case 2:
        return FoodScreen();
      case 3:
        return CategoryScreen();
      case 4:
        return TableScreen();
      case 5:
        return AccountScreen();
      case 6:
        return AccountTypeScreen();
      case 7:
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
            ),
            body: _buildScreen(context),
            resizeToAvoidBottomPadding: false,
            drawer: this._buildDrawer(context)));
  }
}
