class FoodCategory{
  int _id;
  String _name;

  set nameFoodCategory(String value) => this._name = value;

  int get idFoodCategory => this._id;
  String get nameFoodCategory => this._name;

  FoodCategory({id: 0, name: 'No Name'}) 
  : this._id = id,
    this._name = name;
    
  FoodCategory.fromJson(Map<String, dynamic> json)
  : this._id = json['ID'],
    this._name = json['Name'];
}