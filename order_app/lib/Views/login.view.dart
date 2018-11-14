import 'package:flutter/material.dart';
import './mainpage.view.dart';
import './../Constants/theme.dart' as theme;

class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextStyle _itemStyle = new TextStyle(
      color: theme.fontColorLight, 
      fontFamily: 'Dosis', 
      fontSize: 16.0,
      fontWeight: FontWeight.w500
    );

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/images/logo.png'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      style: _itemStyle,
      decoration: InputDecoration(
        hintText: 'Email',
        hintStyle: _itemStyle,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      style: _itemStyle,
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: _itemStyle,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 24.0),
      child: new GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            new MaterialPageRoute(builder: (context) {
              return new MainPage();
            }),
          );
        },
        child: new Container(
          alignment: Alignment(0.0, 0.0),
          color: Color.fromARGB(255, 243, 73, 73),
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.only(bottom: 8.0),
          width: double.infinity,
          child: new Text(
            'Log In',
            style: _itemStyle,
          ),
        ),
      )
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: _itemStyle,
      ),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            forgotLabel
          ],
        ),
      ),
    );
  }
}