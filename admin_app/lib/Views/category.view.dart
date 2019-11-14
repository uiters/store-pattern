import 'package:flutter/material.dart';

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
  TextEditingController _keywordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    const TextStyle _itemStyle = TextStyle(color: theme.fontColor, fontFamily: 'Dosis', fontSize: 16.0);

    Widget controls = new Container(
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: theme.fontColorLight.withOpacity(0.2))),
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
                new Icon(
                  Icons.add,
                  color: theme.fontColorLight,
                  size: 19.0,
                ),
                new Text(
                  'Add',
                  style: theme.contentTable,
                )
              ],
            ),
            onPressed: () {
              _pushAddCategoryScreen();
            },
          ),
          new Container(
            width: 30.0,
          ),
          new Flexible(
              child: new TextField(
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

    Widget table = new FutureBuilder<List<category.Category>>(
      future: categories,
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
          child: new ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              new Table(
                  defaultColumnWidth: FlexColumnWidth(4.0),
                  columnWidths: {0: FlexColumnWidth(1.0), 2: FlexColumnWidth(5.0)},
                  border: TableBorder.all(width: 1.0, color: theme.fontColorLight),
                  children: _buildListRow(categories)),
            ],
          )),
    );
  }

  TableRow _buildTableHead() {
    return new TableRow(children: [
      new TableCell(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'ID',
              style: theme.headTable,
            ),
          ],
        ),
      ),
      new TableCell(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Name',
              style: theme.headTable,
            ),
          ],
        ),
      ),
      new TableCell(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Actions',
              style: theme.headTable,
            ),
          ],
        ),
      )
    ]);
  }

  TableRow _buildTableData(category.Category category) {
    return new TableRow(children: [
      new TableCell(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              category.id.toString(),
              style: theme.contentTable,
            ),
          ],
        ),
      ),
      new TableCell(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              category.name,
              style: theme.contentTable,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      new TableCell(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new RaisedButton(
              color: Colors.lightBlueAccent,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Icon(
                    Icons.edit,
                    color: theme.fontColorLight,
                    size: 19.0,
                  ),
                  new Text(
                    'Edit',
                    style: theme.contentTable,
                  )
                ],
              ),
              onPressed: () {
                _pushEditCategoryScreen(category);
              },
            ),
            new RaisedButton(
              color: Colors.redAccent,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Icon(
                    Icons.delete,
                    color: theme.fontColorLight,
                    size: 19.0,
                  ),
                  new Text(
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
            title: new Text('Confirm', style: theme.titleStyle),
            content: new Text('Do you want to delete this category: ' + category.name + '?',
                style: theme.contentStyle),
            actions: <Widget>[
              new FlatButton(
                  child: new Text('Ok', style: theme.okButtonStyle),
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
              new FlatButton(
                child: new Text('Cancel', style: theme.cancelButtonStyle),
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
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text(
              'Add Category',
              style: new TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),
            ),
            iconTheme: new IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: new AddCategoryScreen(),
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
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text(
              'Edit Category',
              style: new TextStyle(color: theme.accentColor, fontFamily: 'Dosis'),
            ),
            iconTheme: new IconThemeData(color: theme.accentColor),
            centerTitle: true,
          ),
          body: new EditCategoryScreen(category: category),
        );
      }),
    ).then((value) {
      setState(() {
        categories = Controller.instance.categories;
      });
    });
  }
}
