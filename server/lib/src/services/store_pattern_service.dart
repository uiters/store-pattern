import 'dart:async';

import 'package:store_pattern_service/src/services/mysql_connectior.dart';

abstract class StorePatternService {
  Future<int> executeNoneQuery(String query);
  Future<List> executeQuery(String query);
}

class StorePatternServiceImpl extends StorePatternService {
  final con = MySQLConnector();

  @override
  Future<int> executeNoneQuery(String query) {
    return con.getConnection((conection) =>
        conection.query(query).then((value) => value.affectedRows > 0 ? 1 : 0));
  }

  @override
  Future<List> executeQuery(String query) {
    return con.getConnection((conection) => conection
        .query(query)
        .then((value) => value.toList().map((item) => item.fields).toList()));
  }
}
