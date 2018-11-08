import './../Models/menu.model.dart';
import 'dart:typed_data';

class Controller {
  static Controller _instance;

  static Controller get instance {
    if (_instance == null) _instance = new Controller();
    return _instance;
  }

  Future<List<Food>> images;
  

  Future<List<FoodCategory>> get foodCategories => Model.instance.foodCategories;
  Future<List<Food>> get foods {
    if(images == null)
      images = _combineFoodsImages();
    return images;
  }



  Future<Map<int, Uint8List>> get _images => _syncMySqlWithFile();
  Future<Map<int, Uint8List>> get _imagesFile => Model.instance.imagesFile;
  Future<List> get _idImagesMySQL => Model.instance.idImagesMySQL;

  Future<Uint8List> _getImageByID(int id) => Model.instance.getImageById(id);

  Future<void> _saveFile(int id, Uint8List image) async => Model.instance.saveImage(id, image);
  Future<void> _deleteFile(int id) async => Model.instance.delete(id);
  void _link(Food food, Uint8List image) => food.image = image;

  Future<List<Food>> _combineFoodsImages() async {
    Map<int, Uint8List> images = await this._images;
    List<Food> foods = await Model.instance.foods;
    int idImage = 0;
    for (int i = 0; i < foods.length; ++i) {
      idImage = foods[i].idImange;
      _link(foods[i], images[idImage]);
    }

    return foods;
  }

  Future<Map<int, Uint8List>> _syncMySqlWithFile() async {
    List idImagesMySQL = await this._idImagesMySQL;
    Map<int, Uint8List> imagesFile = await this._imagesFile;
    Map<int, Uint8List> images = {};
    int id = 0;
    for(int i = 0; i < idImagesMySQL.length; ++i)
    {
      id = int.parse(idImagesMySQL[i]['ID']); // id in database
      print("ID = $id ");
      if(imagesFile[id] == null)
      {
        print('Null');
        final temp = await _getImageByID(id);
        _saveFile(id, temp); // save async image in database to file
        images[id] = temp;
      }else
      {
        print('Not Null');        
        images[id] = imagesFile[id];
        imagesFile.remove(id); // remove async image exists in database
      }
    }
    imagesFile.forEach((key, value) => _deleteFile(key)); /// delete Image don't exists in database
    return images;
  }
}