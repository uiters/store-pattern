class Model {

  static final List<int> _tableNumbers = [];

  static List<int> get tableNumbers => _tableNumbers;
  

  static void generateNumbers() {
    for (int i = 0; i < 20; i++) {
      _tableNumbers.add(i+1);
    }
  }

}