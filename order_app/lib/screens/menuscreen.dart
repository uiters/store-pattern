import 'package:flutter/material.dart';
import './../UI/theme.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: fontColorLight.withOpacity(0.2))),
      margin: EdgeInsets.all(5.0),
      child: new ListView.builder(
          itemExtent: 175.0,
          itemCount: 20,
          itemBuilder: (_, index) => _buildFoodRow(context)),
    );
  }
}

Widget _buildFoodRow(BuildContext context) {
  return new Container(
    child: new Row(
      children: <Widget>[
        new Expanded(child: _buildFood(context)),
        new Expanded(child: _buildFood(context)),
      ],
    ),
  );
}

Widget _buildFood(BuildContext context) {
  return new Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: new Card(
        color: primaryColor,
        child: new Column(
          children: <Widget>[
            new Text(
              'Pizza',
              style: const TextStyle(
                  color: fontColor, fontFamily: 'Dosis', fontSize: 20.0
              ),
            ),
            new Row(
              children: <Widget>[
                new Expanded(child: new Container()),
                new Image.asset(
                  'assets/images/menu8.png',
                  width: 122.0,
                  height: 122.0,
                  fit: BoxFit.cover,
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new IconButton(
                      icon: new Icon(Icons.remove, size: 16.0, color: fontColorLight,),
                      //                              onPressed: food.quantity == 0 ? null : decrement,
                    ),
                    new Container(
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: fontColor
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 1.0, bottom: 1.0, left: 4.0, right: 4.0),
                          child: new Text('2',
                              style: new TextStyle(
                                  color: Colors.white, fontFamily: 'Dosis', fontSize: 16.0,
                              ),
                              textAlign: TextAlign.center
                          ),
                        )
                    ),
                    new IconButton(
                      icon: new Icon(Icons.add, size: 16.0, color: fontColorLight,),
                      //                              onPressed: increment,
                    ),
                  ],
                ),
                new Expanded(child: new Container())
              ],
            ),
            new Text(
              '\$15',
              style: const TextStyle(
                  color: fontColor, fontFamily: 'Dosis', fontSize: 14.0, fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      )
  );
}