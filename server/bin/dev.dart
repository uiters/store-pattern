import 'dart:io';
import 'package:store_pattern_service/src/pretty_logging.dart';
import 'package:store_pattern_service/store_pattern_service.dart';
import 'package:angel_container/mirrors.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_hot/angel_hot.dart';
import 'package:logging/logging.dart';

void main() async {
  // Watch the config/ and web/ directories for changes, and hot-reload the server.
  hierarchicalLoggingEnabled = true;

  var hot = HotReloader(() async {
    var logger = Logger.detached('store_pattern_service')
      ..level = Level.ALL
      ..onRecord.listen(prettyLog);
    var app = Angel(logger: logger, reflector: MirrorsReflector());
    await app.configure(configureServer);
    return app;
  }, [
    Directory('config'),
    Directory('lib'),
  ]);

  var server = await hot.startServer('127.0.0.1', 3000);
  print(
      'store_pattern_service server listening at http://${server.address.address}:${server.port}');
}
