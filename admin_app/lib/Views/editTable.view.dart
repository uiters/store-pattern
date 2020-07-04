import 'package:flutter/material.dart';

import './../Constants/dialog.dart';
import './../Constants/theme.dart' as theme;
import './../Controllers/table.controller.dart' as tableController;
import './../Models/table.model.dart' as model;

class EditCategoryScreen extends StatefulWidget {
  EditCategoryScreen({key, this.table}) : super(key: key);

  final model.Table table;

  _EditCategoryScreenState createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    _idController.text = widget.table.id.toString();
    _nameController.text = widget.table.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _itemStyle =
        TextStyle(color: theme.fontColor, fontFamily: 'Dosis', fontSize: 16.0, fontWeight: FontWeight.w500);

    TextStyle _itemStyle2 =
        TextStyle(color: theme.accentColor, fontFamily: 'Dosis', fontSize: 18.0, fontWeight: FontWeight.w500);

    Widget id = TextField(
      enabled: false,
      controller: _idController,
      style: _itemStyle,
      decoration: InputDecoration(labelText: 'ID:*', labelStyle: _itemStyle2),
    );

    Widget name = TextField(
      controller: _nameController,
      style: _itemStyle,
      decoration: InputDecoration(labelText: 'Name:', labelStyle: _itemStyle2),
    );

    Widget saveChange = Container(
      margin: const EdgeInsets.only(top: 15.0),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          color: Colors.redAccent,
          child: Text(
            'Save Change',
            style: _itemStyle,
          ),
          onPressed: () {
            _updateTable();
          },
        ),
      ),
    );

    return Container(
      child: Container(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
            scrollDirection: Axis.vertical,
            children: <Widget>[id, name, saveChange],
          )),
    );
  }

  void _updateTable() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm', style: theme.titleStyle),
            content: Text('Do you want to update this table ?', style: theme.contentStyle),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok', style: theme.okButtonStyle),
                onPressed: () async {
                  /* Pop screens */
                  Navigator.of(context).pop();
                  if (_nameController.text.trim() != '') {
                    if (await tableController.Controller.instance
                        .updateTable(widget.table.id, _nameController.text)) {
                      // reload tables
                      tableController.Controller.instance
                          .updateTableToLocal(widget.table.id, _nameController.text, -1);

                      successDialog(this.context, 'Update table success!');
                    } else
                      errorDialog(this.context, 'Update table failed.' + '\nPlease try again!');
                    return;
                  }
                  errorDialog(this.context, 'Invalid name.' + '\nPlease try again!');
                },
              ),
              FlatButton(
                child: Text('Cancel', style: theme.cancelButtonStyle),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
