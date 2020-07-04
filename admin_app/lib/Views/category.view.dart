import 'package:flutter/material.dart';
import 'package:order_app/utils/log.dart';

import './../Constants/dialog.dart';
import './../Constants/theme.dart' as theme;
import './../Controllers/category.controller.dart';
import './../Models/category.model.dart' as category;
import './addCategory.view.dart';
import './editCategory.view.dart';

class CategoryScreen extends StatefulWidget {
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Future<List<category.Category>> categories = Controller.instance.categories;
  TextEditingController _keywordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const TextStyle _itemStyle = TextStyle(color: theme.fontColor, fontFamily: 'Dosis', fontSize: 16.0);

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
              _pushAddCategoryScreen();
            },
          ),
          Container(
            width: 30.0,
          ),
          Flexible(
              child: TextField(
                  controller: _keywordController,
                  onChanged: (text) {
                    setState(() {
                      categories = Controller.instance.searchCategories(text);
                    });
                  },
                  onSubmitted: null,
                  style: _itemStyle,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Enter your category...',
                    hintStyle: _itemStyle,
                  ))),
        ],
      ),
    );

    Widget table = FutureBuilder<List<category.Category>>(
      future: categories,
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

  List<TableRow> _buildListRow(List<category.Category> categories) {
    List<TableRow> listRow = [_buildTableHead()];
    for (var item in categories) {
      listRow.add(_buildTableData(item));
    }
    return listRow;
  }

  Widget _buildTable(List<category.Category> categories) {
    return Expanded(
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(7.0),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Table(
                  defaultColumnWidth: FlexColumnWidth(4.0),
                  columnWidths: {0: FlexColumnWidth(1.0), 2: FlexColumnWidth(5.0)},
                  border: TableBorder.all(width: 1.0, color: theme.fontColorLight),
                  children: _buildListRow(categories)),
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
              'Actions',
              style: theme.headTable,
            ),
          ],
        ),
      )
    ]);
  }

  TableRow _buildTableData(category.Category category) {
    return TableRow(children: [
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              category.id.toString(),
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
              category.name,
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
            RaisedButton(
              color: Colors.lightBlueAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    Icons.edit,
                    color: theme.fontColorLight,
                    size: 19.0,
                  ),
                  Text(
                    'Edit',
                    style: theme.contentTable,
                  )
                ],
              ),
              onPressed: () {
                _pushEditCategoryScreen(category);
              },
            ),
            RaisedButton(
              color: Colors.redAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    Icons.delete,
                    color: theme.fontColorLight,
                    size: 19.0,
                  ),
                  Text(
                    'Delete',
                    style: theme.contentTable,
                  )
                ],
              ),
              onPressed: () {
                _deleteCategory(category);
              },
            ),
          ],
        ),
      )
    ]);
  }

  void _deleteCategory(category.Category category) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm', style: theme.titleStyle),
            content: Text('Do you want to delete this category: ' + category.name + '?',
                style: theme.contentStyle),
            actions: <Widget>[
              FlatButton(
                  child: Text('Ok', style: theme.okButtonStyle),
                  onPressed: () async {
                    /* Pop screens */
                    Navigator.of(context).pop();
                    if (!(await Controller.instance.isCategoryExists(category.id))) {
                      if (await Controller.instance.deleteCategory(category.id)) {
                        Controller.instance.deleteCateToLocal(category.id);
                        setState(() {
                          categories = Controller.instance.categories;
                        });
                        successDialog(this.context, 'Delete this category: ' + category.name + ' success!');
                      } else
                        errorDialog(this.context,
                            'Delete this category: ' + category.name + ' failed.' + '\nPlease try again!');
                    } else
                      errorDialog(
                          this.context,
                          'Can\'t delete this category: ' +
                              category.name +
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

  void _pushAddCategoryScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Add Category',
              style: TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),
            ),
            iconTheme: IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: AddCategoryScreen(),
        );
      }),
    ).then((value) {
      setState(() {
        categories = Controller.instance.categories;
      });
    });
  }

  void _pushEditCategoryScreen(category.Category category) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Category',
              style: TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),
            ),
            iconTheme: IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: EditCategoryScreen(category: category),
        );
      }),
    ).then((value) {
      setState(() {
        categories = Controller.instance.categories;
      });
    });
  }
}
