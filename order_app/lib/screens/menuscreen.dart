import 'package:flutter/material.dart';
import './../UI/theme.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildFilterFood(context),
          _buildListFoods(context)
        ],
      ),
    );
  }


  Widget _buildListFoods(BuildContext context) {
    return Expanded(
      child: new Container(
        width: double.infinity,
        margin: EdgeInsets.all(5.0),
        child: new ListView.builder(
            itemExtent: 175.0,
            itemCount: 20,
            itemBuilder: (_, index) => _buildFoodRow(context)
        ),
      ),
    );
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
                        icon: new Icon(
                          Icons.remove, size: 16.0, color: fontColorLight,),
                        onPressed: () {},
                      ),
                      new Container(
                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: fontColor
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 1.0, bottom: 1.0, left: 4.0, right: 4.0),
                            child: new Text('2',
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Dosis',
                                  fontSize: 16.0,
                                ),
                                textAlign: TextAlign.center
                            ),
                          )
                      ),
                      new IconButton(
                        icon: new Icon(
                          Icons.add, size: 16.0, color: fontColorLight,),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  new Expanded(child: new Container())
                ],
              ),
              new Text(
                '\$15',
                style: const TextStyle(
                    color: fontColor,
                    fontFamily: 'Dosis',
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget _buildFilterFood(BuildContext context) {
    TextStyle _itemStyle = new TextStyle(
        color: fontColor, fontFamily: 'Dosis', fontSize: 16.0);
    return new Container(
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: fontColorLight.withOpacity(0.2))
      ),
      margin: EdgeInsets.only(top: 10.0, bottom: 2.0, left: 7.0, right: 7.0),
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: new Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: new Row(
              children: <Widget>[
                new Flexible(
                    child: new TextField(
                        controller: _textController,
                        onChanged: null,
                        onSubmitted: null,
                        style: _itemStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Enter your food...',
                            hintStyle: _itemStyle
                        )
                    )
                ),
                new Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: new IconButton(
                      icon: new Icon(
                        Icons.search, color: fontColorLight, size: 16.0,),
                      onPressed: null,
                    )
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: new DropdownButton(
                items: [
                  new DropdownMenuItem(child: new Text(
                    'Donec mollis tellus et', style: _itemStyle,)),
                  new DropdownMenuItem(
                      child: new Text('Donec nisi sem', style: _itemStyle,)),
                  new DropdownMenuItem(
                      child: new Text('Mauris posuere', style: _itemStyle,)),
                  new DropdownMenuItem(
                      child: new Text('Ut faucibus', style: _itemStyle,)),
                ],
                onChanged: null
            ),
          )
        ],
      ),
    );
  }

}