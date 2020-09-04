class QueryRequest {
  String query;
  bool isNoneQuery;

  QueryRequest.fromJson(Map<String, dynamic> map) {
    if (map.containsKey('executeNoneQuery')) {
      query = map['executeNoneQuery'].toString();
      isNoneQuery = true;
    } else if (map.containsKey('executeQuery')) {
      query = map['executeQuery'].toString();
      isNoneQuery = false;
    } else {
      throw Exception('Query incorrect');
    }
  }
}
