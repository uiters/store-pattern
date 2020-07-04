import 'package:flutter/material.dart';
import 'package:admin_app/utils/log.dart';

import './../Constants/dialog.dart';
import './../Constants/theme.dart' as theme;
import './../Controllers/food.controller.dart';
import './../Models/food.model.dart' as food;
import './addFood.view.dart';
import './editFood.view.dart';
import './foodDetail.view.dart';

class FoodScreen extends StatefulWidget {
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  Future<List<food.Food>> foods = Controller.instance.foods;
  TextEditingController _keywordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const TextStyle _itemStyle =
        TextStyle(color: theme.fontColor, fontFamily: 'Dosis', fontSize: 16.0);

    Widget controls = Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: theme.fontColorLight.withOpacity(0.2))),
      margin: EdgeInsets.only(top: 10.0, bottom: 2.0, left: 7.0, right: 7.0),
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RaisedButton(
            color: Colors.greenAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(
                  Icons.add,
                  color: theme.fontColorLight,
                  size: 19.0,
                ),
                Text(
                  'Add',
                  style: theme.contentTable,
                )
              ],
            ),
            onPressed: () {
              _pushAddFoodScreen();
            },
          ),
          Container(
            width: 30.0,
          ),
          Flexible(
              child: TextField(
                  controller: _keywordController,
                  onChanged: (keyword) {
                    setState(() {
                      foods = Controller.instance.searchFoods(keyword);
                    });
                  },
                  onSubmitted: null,
                  style: _itemStyle,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Enter your food...',
                    hintStyle: _itemStyle,
                  ))),
        ],
      ),
    );

    Widget table = FutureBuilder<List<food.Food>>(
      future: foods,
      builder: (context, snapshot) {
        if (snapshot.hasError) Log.error(snapshot.error);
        if (snapshot.hasData) {
          return _buildTable(snapshot.data);
        }
        return Center(child: CircularProgressIndicator());
      },
    );

    return Container(
      child: Column(
        children: <Widget>[controls, table],
      ),
    );
  }

  List<TableRow> _buildListRow(List<food.Food> foods) {
    List<TableRow> listRow = [_buildTableHead()];
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
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Table(
                  defaultColumnWidth: FlexColumnWidth(2.0),
                  columnWidths: {
                    0: FlexColumnWidth(0.5),
                    1: FlexColumnWidth(3.0),
                    3: FlexColumnWidth(1.5),
                    4: FlexColumnWidth(3.0)
                  },
                  border: TableBorder.all(width: 1.0, color: theme.fontColorLight),
                  children: _buildListRow(foods)),
            ],
          )),
    );
  }

  TableRow _buildTableHead() {
    return TableRow(children: [
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'ID',
              style: theme.headTable,
            ),
          ],
        ),
      ),
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Name',
              style: theme.headTable,
            ),
          ],
        ),
      ),
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Category',
              style: theme.headTable,
            ),
          ],
        ),
      ),
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Price',
              style: theme.headTable,
            ),
          ],
        ),
      ),
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Actions',
              style: theme.headTable,
            ),
          ],
        ),
      )
    ]);
  }

  TableRow _buildTableData(food.Food food) {
    return TableRow(children: [
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              food.id.toString(),
              style: theme.contentTable,
            ),
          ],
        ),
      ),
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              food.name,
              style: theme.contentTable,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              food.category,
              style: theme.contentTable,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '\$' + food.price.toString(),
              style: theme.contentTable,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              color: Colors.redAccent,
              icon: Icon(
                Icons.edit,
                color: Colors.orangeAccent,
                size: 19.0,
              ),
              onPressed: () {
                _pushEditFoodScreen(food);
              },
            ),
            IconButton(
              color: Colors.redAccent,
              icon: Icon(
                Icons.delete,
                color: Colors.redAccent,
                size: 19.0,
              ),
              onPressed: () {
                _deleteFood(food);
              },
            ),
            IconButton(
              color: Colors.redAccent,
              icon: Icon(
                Icons.info,
                color: Colors.blueAccent,
                size: 19.0,
              ),
              onPressed: () {
                _pushDetailsFoodScreen(food);
              },
            ),
          ],
        ),
      )
    ]);
  }

  void _deleteFood(food.Food food) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm', style: theme.titleStyle),
            content: Text('Do you want to delete this food: ' + food.name + '?',
                style: theme.contentStyle),
            actions: <Widget>[
              FlatButton(
                  child: Text('Ok', style: theme.okButtonStyle),
                  onPressed: () async {
                    /* Pop screens */
                    Navigator.of(context).pop();
                    if (!(await Controller.instance.isFoodExists(food.id))) {
                      if (await Controller.instance.deleteFood(food.id)) {
                        Controller.instance.deleteFoodToLocal(food.id);
                        setState(() {
                          foods = Controller.instance.foods;
                        });
                        successDialog(
                            this.context, 'Delete this food: ' + food.name + ' success!');
                      } else
                        errorDialog(
                            this.context,
                            'Delete this food: ' +
                                food.name +
                                ' failed.' +
                                '\nPlease try again!');
                    } else
                      errorDialog(
                          this.context,
                          'Can\'t delete this food: ' +
                              food.name +
                              '?' +
                              '\nContact with team dev for information!');
                  }),
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

  void _pushAddFoodScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Add Food',
              style: TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),
            ),
            iconTheme: IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: AddFoodScreen(),
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
      MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Update Food',
              style: TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),
            ),
            iconTheme: IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: EditFoodScreen(food: food),
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
      MaterialPageRoute(builder: (context) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                'Food Details',
                style: TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),
              ),
              iconTheme: IconThemeData(color: theme.accentColor),
              centerTitle: true,
            ),
            body: FoodDetailScreen(
              food: food,
            ));
      }),
    );
  }
}
