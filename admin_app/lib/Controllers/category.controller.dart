import './../Models/category.model.dart';

class Controller {
  static Controller _instance;

  static Controller get instance {
    if (_instance == null) _instance = new Controller();
    return _instance;
  }

  Future<List<Category>> _categories;

  Future<List<Category>> get categories {
    if (_categories == null) _categories = Model.instance.getCategories();
    return _categories;
  }

  Future<bool> insertCategory(String name) => Model.instance.insertCategory(name);

  Future<bool> updateCategory(int id, String name) => Model.instance.updateCategory(id, name);

  Future<bool> deleteCategory(int id) => Model.instance.deleteCategory(id);

  Future<bool> isCategoryExists(int id) => Model.instance.isCategoryExists(id);

  Future<List<Category>> searchCategories(String keyword) async {
    List<Category> items = await categories;
    if (keyword.trim() == '') return items;
    return items.where((item) => item.name.toUpperCase().indexOf(keyword.toUpperCase()) != -1).toList();
  }

  void insertCateToLocal(String name) async {
    int idMax = await Model.instance.getIDMax();
    Category cate = new Category(idMax, name);
    (await categories).add(cate);
  }

  void updateCateToLocal(int id, String name) async {
    int index = await findIndex(id);
    (await categories)[index].name = name;
  }

  void deleteCateToLocal(int id) async {
    int index = await findIndex(id);
    (await categories).removeAt(index);
  }

  Future<int> findIndex(int id) async {
    for (var i = 0; i < (await categories).length; i++) {
      if ((await categories)[i].id == id) return i;
    }
    return -1;
  }
}
