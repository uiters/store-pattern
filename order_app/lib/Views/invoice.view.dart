import 'package:flutter/material.dart';

import './../Constants/theme.dart' as theme;

class InvoiceScreen extends StatefulWidget {
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: new Column(
         children: <Widget>[
          _buildHeader(),
          _buildBody(),
          _buildFooter()
         ],
       ),
    );
  }

  Widget _buildHeader() {
    return new Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: new Row(
        children: <Widget>[
          Expanded(child: Container(),),
          new Text(
            'Table 1',
            style: new TextStyle(
              color: theme.accentColor, 
              fontFamily: 'Dosis',
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(child: Container(),),
          new Column(
            children: <Widget>[
              new Text(
                'ID# 12349',
                style: new TextStyle(
                  color: theme.fontColor, 
                  fontFamily: 'Dosis', 
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500
                ),
              ),
              new Text(
                '4:58 PM, Nov 10',
                style: new TextStyle(
                  color: theme.fontColor, 
                  fontFamily: 'Dosis', 
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500
                ),              
              )
            ],
          ),
          Expanded(child: Container(),),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: new ListView.builder(
          itemExtent: 60.0,
          itemCount: 10,
          itemBuilder: (_, index) => _buildFood()
        ),
      ),
    );
  }

  Widget _buildFood() {
    return new Container(
    padding: EdgeInsets.zero,
    margin: EdgeInsets.zero,
    child: new Card(
      color: theme.primaryColor,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Expanded(child: new Container()),
          new Text(
            'Food 1',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: theme.accentColor, 
              fontFamily: 'Dosis', 
              fontSize: 18.0
            ),
          ),
          new Expanded(child: new Container()),
          new Text(
            '\$20',
            style: const TextStyle(
              color: theme.fontColor,
              fontFamily: 'Dosis',
              fontSize: 14.0,
              fontWeight: FontWeight.w600
            ),
          ),
          new Expanded(child: new Container()),
          new Text(
            '4',
            style: const TextStyle(
              color: theme.fontColor,
              fontFamily: 'Dosis',
              fontSize: 15.0,
              fontWeight: FontWeight.w500
            ),
          ),
          new Expanded(child: new Container()),
          new Text(
            '\$80',
            style: const TextStyle(
              color: theme.fontColor,
              fontFamily: 'Dosis',
              fontSize: 14.0,
              fontWeight: FontWeight.w500
            ),
          ),
          new Expanded(child: new Container()),
        ],
      ),
    )
    );
  }

  Widget _buildFooter() {
    TextStyle _itemStyle = new TextStyle(
      color: theme.fontColor, 
      fontFamily: 'Dosis', 
      fontSize: 16.0,
      fontWeight: FontWeight.w500
    );

    return new Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: theme.fontColorLight.withOpacity(0.2)),
        color: theme.primaryColor
      ),
      margin: EdgeInsets.only(top: 2.0, bottom: 7.0, left: 7.0, right: 7.0),
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0),
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Text(
                'Subtotal: ',
                style: _itemStyle,
              ),
              new Expanded(child: Container()),
              new Text(
                '\$1000',
                style: _itemStyle,
              )
            ],
          ),
          new Divider(),
          new Row(
            children: <Widget>[
              new Text(
                'Discount: ',
                style: _itemStyle,
              ),
              new Expanded(child: Container()),
              new Text(
                '10%',
                style: _itemStyle,
              )
            ],
          ),
          new Divider(),
          new Row(
            children: <Widget>[
              new Text(
                'Total: ',
                style: _itemStyle,
              ),
              new Expanded(child: Container()),
              new Text(
                '\$900',
                style: _itemStyle,
              )
            ],
          ),
        ],
      ),
    );
  }
}