import 'package:flutter/material.dart';

import './../Controllers/login.controller.dart';

import './mainpage.view.dart';

import './../Constants/theme.dart' as theme;

class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  String _username = '';
  String _password = '';

  bool _load = false;

  @override
  Widget build(BuildContext context) {
    TextStyle _itemStyle = new TextStyle(
      color: theme.fontColor, 
      fontFamily: 'Dosis', 
      fontSize: 16.0,
      fontWeight: FontWeight.w500
    );

    TextStyle _itemStyle2 = new TextStyle(
      color: theme.fontColorLight, 
      fontFamily: 'Dosis', 
      fontSize: 16.0,
      fontWeight: FontWeight.w500
    );

    TextStyle _itemStyle3 = new TextStyle(
      color: theme.accentColor, 
      fontFamily: 'Dosis', 
      fontSize: 28.0,
      fontWeight: FontWeight.w400,
    );

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 100.0,
        child: Image.asset('assets/images/logo.png'),
      ),
    );

    final title = new Center(
      child: new Text(
        'Order App',
        style: _itemStyle3,
      ),
    );

    final email = TextField(
      controller: _usernameController,
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      style: _itemStyle,
      onChanged: (value) {
        _username = value;
      },
      decoration: InputDecoration(
        hintText: 'Username',
        hintStyle: _itemStyle2,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextField(
      controller: _passwordController,
      style: _itemStyle,
      obscureText: true,
      onChanged: (value) {
        _password = value;
      },
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: _itemStyle2,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = new Container(
      child: SizedBox(
        width: double.infinity,
        child: new RaisedButton(
          color: Colors.redAccent,
          child: new Text(
            'Login',
            style: _itemStyle,
          ),
          onPressed: () async {
            if (_password == '' || _username == '') {
              _notification('Error', 'Invalid user name or password. Please try again.');
              return;
            }
            setState(() {
              _load = true;
            });
            if (await Controller.instance.login(_username.trim(), _password.trim())) {
              Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) {
                  return new MainPage(context: context, account: Controller.instance.account,);
                }),
              );
              _clear();
            } else {
              _notification('Error', 'Username or Password is incorrect!');
              _clear();
            }
            setState(() {
              _load = false;
            });
          },
        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: _itemStyle,
      ),
      onPressed: () {
        
      },
    );

    Widget loadingIndicator = _load ? new Container(
      color: Colors.transparent,
      width: 180.0,
      height: 120.0,
      child: new Card(
        color: theme.primaryColor,
        child: Row(
          children: <Widget>[
            new Expanded(child: new Container(),),
            new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(theme.accentColor),
            ),
            new Expanded(child: new Container(),),
            new Text(
              'Logining...',
              style: theme.contentStyle,
            ),
            new Expanded(child: new Container(),),
          ],
        ),
      )
    ) : new Container();

    return Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(
        children: <Widget>[
          new Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                logo,
                SizedBox(height: 15.0),
                title,
                SizedBox(height: 48.0),
                email,
                SizedBox(height: 10.0),
                password,
                SizedBox(height: 24.0),
                loginButton,
                forgotLabel
              ],
            ),
          ),
          new Align(child: loadingIndicator,alignment: FractionalOffset.center,),
        ],
      )
      
    );
  }

  void _clear() {
    _usernameController.clear();
    _passwordController.clear();
    _username = '';
    _password = '';
  }

  void _notification(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            title,
            style: theme.errorTitleStyle
          ),
          content: new Text(
            message,
            style: theme.contentStyle 
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                'Ok',
                style: theme.okButtonStyle 
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

}
