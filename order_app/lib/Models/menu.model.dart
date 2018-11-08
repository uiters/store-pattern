import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import './connectServer.dart';
import './../Constants/queries.dart';

class Model {
  static Model _instance;

  static Model get instance {
    if (_instance == null) _instance = new Model();
    return _instance;
  }


  Future<List<FoodCategory>> get foodCategories => getFoodCategories();
  Future<List<Food>> get foods => getFoods();

  Future<List> get idImagesMySQL => _getIDImagesFromMySQL();
  Future<Map<int, Uint8List>>  get imagesFile => _getImagesFromFile();

  Future<Uint8List> getImageById(int id) => _parseImage(_getImagesById(id));
  Future<void> saveImage(int id, Uint8List image) => _saveImage(id, image);
  Future<void> delete(int id) => _delete(id);
  
  
      static Future<List<FoodCategory>> getFoodCategories() async {
        Future<List> futureFoodCategories =
            MySqlConnection.instance.executeQuery(QUERY_GET_FOOD_CATEGORIES);
        return parseFoodCate(futureFoodCategories);
      }
    
      static Future<List<Food>> getFoods() async {
        Future<List> futureFoods =
            MySqlConnection.instance.executeQuery(QUERY_GET_FOODS);
        return parseFood(futureFoods);
      }
    
      ///get from database
      Future<List> _getIDImagesFromMySQL() => MySqlConnection.instance.executeQuery(QUERY_GET_ID_IMAGES);
  
      Future<List> _getImagesById(int id) => MySqlConnection.instance.executeQuery(QUERY_GET_IMAGE_BY_ID, parameter: [id]);
  
      
      Future<Map<int, Uint8List>> _getImagesFromFile() async {
        String pathLocal = await _getLocalPath() + '/image';
        Directory directory = new Directory(pathLocal);
        Map<int, Uint8List> futureImages = {};
  
        int idImage;
        Uint8List image;
        if(directory.existsSync())
            directory.listSync().forEach((enity) {
              if(enity is File){
                File file = enity; 
                print(enity);
                idImage = parseID(basename(file.path));
                image = file.readAsBytesSync();
                futureImages[idImage] = image;
              }
            });
        print('${futureImages.length}\n');
        return futureImages;
      }

      Future<void> _saveImage(int id Uint8List image) async {
        String pathLocal = await _getLocalPath() + '/image';
        new Directory(pathLocal).createSync(recursive: true);
        
        final file = new File('$pathLocal/$id.png');
        file.writeAsBytesSync(image, mode: FileMode.write, flush: true);
      }

      Future<void> _delete(int id) async {
        String pathLocal = await _getLocalPath() + '/image';
        final file = new File('$pathLocal/$id.png');
        if(file.existsSync())
          file.deleteSync(recursive: false);
      }

      //-------------------------------------------------------------------------
    
      static Future<List<FoodCategory>> parseFoodCate(
          Future<List> foodCategories) async {
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
          //print('$values\n');
          values.forEach((value) {
            futureFoods.add(Food.fromJson(value));
          });
        });
        print('$futureFoods\n');
        return futureFoods;
      }
    
      Future<Uint8List> _parseImage(Future<List> images) async {
        List image = await images;
        return base64.decode(image[0]['Image']);
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
  int idImange;
  Uint8List image;

  Food({this.id, this.name, this.idFoodCategory, this.price, this.image});

  Food.fromJson(Map<String, dynamic> json) {
    this.id = int.parse(json['ID']);
    this.name = json['Name'];
    this.idFoodCategory = int.parse(json['IDCategory']);
    this.price = double.parse(json['Price']);
    this.idImange = int.parse(json['IDImage']);
    //this.image = base64.decode(json['Image']);
  }
}

Future<String> _getLocalPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

/**
 * *Parse [name] -> [int]*
 * 
 * Return [0] if name contains [characters]
 */

int parseID(String name) => int.tryParse(name) ?? 0;

/**
* *Return [name] of path*
*
*     String path = 'flutter/123.png';
*     String name = basename(path); // Name = '123'
*---------------------------------------------------
*     String path = 'flutter/123456';
*     String name = basename(path); // Name = '123456'
*/
String basename(String path) => path.split('/').last.split('.').first;
