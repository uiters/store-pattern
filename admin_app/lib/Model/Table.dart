class Table{
  int _id;
  String _name;
  int _status;

  set nameTable(String value) => this._name = value;
  set statusTable(int value) => this._status = value;

  int get idTable => this._id;
  String get nameTable => this._name;
  int get statusTable => this._status;

  Table({int id : 0, String name: 'No Name', int status: -1})
  : this._id = id,
    this._name = name,
    this._status = status;
  

  Table.fromJson(Map<String, dynamic> json) 
  : this._id = json['ID'],
    this._name = json['Name'],
    this._status = json['Status'];
}