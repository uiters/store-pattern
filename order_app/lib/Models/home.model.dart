class Model {

  static Model _instance;

  static Model get instance {
    if (_instance == null) _instance = new Model();
    return _instance;
  }

  final List<TableData> _tables = [
    new TableData(1, 'Table 1', 1),
    new TableData(2, 'Table 2', 0),
    new TableData(3, 'Table 3', 0),
    new TableData(4, 'Table 4', 0),
    new TableData(5, 'Table 5', 1),
    new TableData(6, 'Table 6', 0),
    new TableData(7, 'Table 7', 1),
    new TableData(8, 'Table 8', 1),
  ];

  List<TableData> get tables => _tables;

}

class TableData {
  int id;
  String name;
  int status;

  TableData(int _id, String _name, int _status) {
    this.id = _id;
    this.name = _name;
    this.status = _status;
  }
}