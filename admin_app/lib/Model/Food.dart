class Food{
  int _id;
  int _idCategory;
  String _name;
  double _price;

  set idFoodCategory(int value) => this._idCategory = value;
  set nameFood(String value) => this._name = value;
  set priceFood(double value) => this._price = value;

  int get idFood => this._id;
  int get idFoodCategory => this._idCategory;
  String get nameFood => this._name;
  double get priceFood => this._price;

  Food({id: 0, idCategory : 'No Name', name: 'No Name', price: -1})
  : this._id = id,
    this._idCategory = idCategory,
    this._name = name,
    this._price = price;
  
  Food.fromJson(Map<String, dynamic> json)
  : this._id = json['ID'],
    this._idCategory = json['IDCategory'],
    this._name = json['Name'],
    this._price = json['Price'];
}