import 'dart:async';

import 'dart:io';

import 'package:mysql1/mysql1.dart';

class MySQLConnector {
  Future<MySqlConnection> _connectMySQL() async {
    final host = Platform.environment['MYSQL_HOST'] ?? '0.0.0.0';
    final port = int.tryParse(Platform.environment['MYSQL_PORT'] ?? '3306');
    final user = Platform.environment['MYSQL_USER'] ?? 'tvc12';
    final password = Platform.environment['MYSQL_PASSWORD'] ?? 'tvc12@222';
    final db = Platform.environment['MYSQL_DATABASE'] ?? 'storepattern';
    final settings = ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db,
      characterSet: CharacterSet.UTF8,
      timeout: const Duration(minutes: 1),
    );
    return MySqlConnection.connect(settings);
  }

  Future<T> getConnection<T>(ConverterFunction<T> converter) async {
    MySqlConnection con;
    try {
      con = await _connectMySQL();
      return await converter(con);
    } finally {
      await con?.close();
    }
  }
}

typedef ConverterFunction<T> = Future<T> Function(MySqlConnection conection);
