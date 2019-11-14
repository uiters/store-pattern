import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

import './../Constants/queries.dart';
import './connectServer.dart';

class Model {
  static Model _instance;

  static Model get instance {
    if (_instance == null) _instance = new Model();
    return _instance;
  }

  Future<String> _localPath;

  Future<List<FoodCategory>> get foodCategories => getFoodCategories();

  Future<List<Food>> get foods => getFoods();

  Future<List> get idImagesMySQL => _getIDImagesFromMySQL();

  Future<Map<int, Uint8List>> get imagesFile => _getImagesFromFile();

  Future<Uint8List> getImageById(int id) => _parseImage(_getImagesById(id));

  Future<void> saveImage(int id, Uint8List image) => _saveImage(id, image);

  Future<void> delete(int id) => _delete(id);

  ///get from database
  Future<List> _getIDImagesFromMySQL() => MySqlConnection.instance.executeQuery(QUERY_GET_ID_IMAGES);

  Future<List> _getImagesById(int id) =>
      MySqlConnection.instance.executeQuery(QUERY_GET_IMAGE_BY_ID, parameter: [id]);

  Future<String> get localPath {
    if (_localPath == null) _localPath = _getLocalPath();
    return _localPath;
  }

  Future<Map<int, Uint8List>> _getImagesFromFile() async {
    String pathLocal = await this.localPath + '/image';
    Directory directory = new Directory(pathLocal);
    Map<int, Uint8List> futureImages = {};
    int idImage;
    Uint8List image;
    if (directory.existsSync()) {
      directory.listSync().forEach((enity) {
        if (enity is File) {
          File file = enity;
          idImage = parseID(basename(file.path));
          image = file.readAsBytesSync();
          futureImages[idImage] = image;
        }
      });
    }
    return futureImages;
  }

  Future<void> _saveImage(int id, Uint8List image) async {
    String pathLocal = await this.localPath + '/image';
    new Directory(pathLocal).createSync(recursive: true);

    final file = new File('$pathLocal/$id.png');
    file.writeAsBytesSync(image, mode: FileMode.write, flush: true);
  }

  Future<void> _delete(int id) async {
    String pathLocal = await this.localPath + '/image';
    final file = new File('$pathLocal/$id.png');
    if (file.existsSync()) file.deleteSync(recursive: false); //false is deleted currently image in this path
  }

  Future<Uint8List> _parseImage(Future<List> images) async {
    List image = await images;
    return base64.decode(image[0]['Image']);
  }

  //-------------------------------------------------------------------------
  Future<List<FoodCategory>> getFoodCategories() async {
    Future<List> futureFoodCategories = MySqlConnection.instance.executeQuery(GET_FOOD_CATEGORIES);
    return parseFoodCate(futureFoodCategories);
  }

  Future<List<Food>> getFoods() {
    Future<List> futureFoods = MySqlConnection.instance.executeQuery(QUERY_GET_FOODS);
    return parseFood(futureFoods);
  }

  static Future<List<FoodCategory>> parseFoodCate(Future<List> foodCategories) async {
    List<FoodCategory> futureFoodCategories = [];
    await foodCategories.then((values) {
      values.forEach((value) {
        futureFoodCategories.add(FoodCategory.fromJson(value));
      });
    });
    return futureFoodCategories;
  }

  static Future<List<Food>> parseFood(Future<List> foods) async {
    List<Food> futureFoods = [];
    await foods.then((values) {
      values.forEach((value) {
        futureFoods.add(Food.fromJson(value));
      });
    });
    return futureFoods;
  }
}

class FoodCategory {
  int id;
  String name;

  FoodCategory({this.id, this.name});

  FoodCategory.fromJson(Map<String, dynamic> json) {
    this.id = int.parse(json['ID']);
    this.name = json['Name'];
  }
}

class Food {
  int id;
  String name;
  int idFoodCategory;
  double price;
  int quantity;
  int idImange;
  Uint8List image;

  Food(Food _food) {
    this.id = _food.id;
    this.name = _food.name;
    this.idFoodCategory = _food.idFoodCategory;
    this.price = _food.price;
    this.quantity = _food.quantity;
    this.image = _food.image;
  }

  //Food({this.id, this.name, this.idFoodCategory, this.price, this.image});

  Food.fromJson(Map<String, dynamic> json) {
    this.id = int.parse(json['ID']);
    this.name = json['Name'];
    this.idFoodCategory = int.parse(json['IDCategory']);
    this.price = double.parse(json['Price']);
    this.quantity = json['Quantity'] != null ? int.parse(json['Quantity']) : 0;
    //this.image = json['Image'] != null ? base64.decode(json['Image']) : null;
    this.idImange = int.parse(json['IDImage']);
    //this.image = base64.decode(json['Image']);
  }
}

Future<String> _getLocalPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

///
/// *Parse [name] -> [int]*
///
/// Return [0] if name contains [characters]
///

int parseID(String name) => int.tryParse(name) ?? 0;

///
/// *Return [name] of path*
///
///     String path = 'flutter/123.png';
///     String name = basename(path); // Name = '123'
///---------------------------------------------------
///     String path = 'flutter/123456';
///     String name = basename(path); // Name = '123456'
///
String basename(String path) => path.split('/').last.split('.').first;
