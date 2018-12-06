import 'package:flutter/material.dart';

import './../Models/food.model.dart' as food;

import './foodDetail.view.dart';
import './addFood.view.dart';

import './../Controllers/food.controller.dart';

import './../Constants/theme.dart' as theme;

class FoodScreen extends StatefulWidget {
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  Future<List<food.Food>> foods = Controller.instance.foods;
  TextEditingController _keywordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    const TextStyle _itemStyle = TextStyle(
      color: theme.fontColor, 
      fontFamily: 'Dosis', 
      fontSize: 16.0
    );
    
    Widget controls = new Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: theme.fontColorLight.withOpacity(0.2))
      ),
      margin: EdgeInsets.only(top: 10.0, bottom: 2.0, left: 7.0, right: 7.0),
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new RaisedButton(
            color: Colors.greenAccent,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Icon(Icons.add, color: theme.fontColorLight, size: 19.0,),
                new Text('Add', style: theme.contentTable,)
              ],
            ),
            onPressed: () {
              _pushAddFoodScreen();
            },
          ),
          new Container(width: 30.0,),
          new Flexible(
            child: new TextField(
              controller: _keywordController,
              onChanged: (text) {},
              onSubmitted: null,
              style: _itemStyle,
              decoration: InputDecoration.collapsed(
                  hintText: 'Enter your food...',
                  hintStyle: _itemStyle,
              )
            )
          ),
          new Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(
                  Icons.search, color: theme.fontColorLight, size: 16.0,),
                onPressed: () {
                  setState(() {
                    foods = Controller.instance.searchFoods(_keywordController.text);
                  });
                },
              )
          )
        ],
      ),
    );

    Widget table = new FutureBuilder<List<food.Food>>(
      future: foods,
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        if (snapshot.hasData) {
          return _buildTable(snapshot.data);
        }
        return Center(child: CircularProgressIndicator());
      },
    );

    return Container(
      child: Column(
        children: <Widget>[
          controls,
          table
        ],
      ),
    );
  }

  List<TableRow> _buildListRow(List<food.Food> foods) {
    List<TableRow> listRow = [
      _buildTableHead()
    ];
    for (var item in foods) {
      listRow.add(_buildTableData(item));
    }
    return listRow;
  }

  Widget _buildTable(List<food.Food> foods) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(7.0),
        child: new ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              new Table(
                defaultColumnWidth: FlexColumnWidth(2.0),
                columnWidths: {
                  0: FlexColumnWidth(0.5),
                  1: FlexColumnWidth(3.0),
                  3: FlexColumnWidth(1.5),
                  4: FlexColumnWidth(3.0)
                },
                border: TableBorder.all(width: 1.0, color: theme.fontColorLight),
                children: _buildListRow(foods)
              ),
            ],
          )
      ),
    );
  }

  TableRow _buildTableHead() {
    return new TableRow(
      children: [
        new TableCell(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('ID', style: theme.headTable,),
            ],
          ),
        ),
        new TableCell(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('Name', style: theme.headTable,),
            ],
          ),
        ),
        new TableCell(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('Category', style: theme.headTable,),
            ],
          ),
        ),
        new TableCell(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('Price', style: theme.headTable,),
            ],
          ),
        ),
        new TableCell(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('Actions', style: theme.headTable,),
            ],
          ),
        )
      ]
    );
  }

  TableRow _buildTableData(food.Food food) {
    return new TableRow(
      children: [
        new TableCell(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(food.id.toString(), style: theme.contentTable,),
            ],
          ),
        ),
        new TableCell(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(food.name, style: theme.contentTable, overflow: TextOverflow.ellipsis,),
            ],
          ),
        ),
        new TableCell(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(food.category, style: theme.contentTable, overflow: TextOverflow.ellipsis,),
            ],
          ),
        ),
        new TableCell(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('\$'+food.price.toString(), style: theme.contentTable, overflow: TextOverflow.ellipsis,),
            ],
          ),
        ),
        new TableCell(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new IconButton(
                color: Colors.redAccent,
                icon: new Icon(Icons.edit, color: Colors.orangeAccent, size: 19.0,),
                onPressed: () {
                  _pushEditFoodScreen(food);
                },
              ),
              new IconButton(
                color: Colors.redAccent,
                icon: new Icon(Icons.delete, color: Colors.redAccent, size: 19.0,),
                onPressed: () {

                },
              ),
              new IconButton(
                color: Colors.redAccent,
                icon: new Icon(Icons.info, color: Colors.blueAccent, size: 19.0,),
                onPressed: () {
                  _pushDetailsFoodScreen(food);
                },
              ),
            ],
          ),
        )
      ]
    );
  }

  void _pushAddFoodScreen() {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text(
              'Add Food',
              style: new TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),),
            iconTheme: new IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: new AddFoodScreen(),
        );
      }),
    ).then((value) {
      setState(() {
        foods = Controller.instance.foods;
      });
    });
  }

  void _pushEditFoodScreen(food.Food food) {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text(
              'Edit Food',
              style: new TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),),
            iconTheme: new IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          // body: new EditCategoryScreen(category: category),
        );
      }),
    ).then((value) {
      setState(() {
        foods = Controller.instance.foods;
      });
    });
  }

  void _pushDetailsFoodScreen(food.Food food) {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text(
              'Food Details',
              style: new TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),),
            iconTheme: new IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: new FoodDetailScreen(food: food,)
        );
      }),
    );
  }
}