import 'package:flutter/material.dart';

import './theme.dart' as theme;

void errorDialog(BuildContext context, String message) {
  if (context != null)
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error', style: theme.errorTitleStyle),
            content: Text(message, style: theme.contentStyle),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok', style: theme.okButtonStyle),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
}

void successDialog(BuildContext context, String message) {
  if (context != null)
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Notification', style: theme.titleStyle),
            content: Text(message, style: theme.contentStyle),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok', style: theme.okButtonStyle),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
}
