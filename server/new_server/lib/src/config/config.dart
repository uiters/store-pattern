library store_pattern_service.src.config;

import 'package:angel_configuration/angel_configuration.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:file/file.dart';
import 'package:store_pattern_service/src/routes/controllers/store_pattern_controller.dart';
import 'package:store_pattern_service/src/services/store_pattern_service.dart';

/// This is a perfect place to include configuration and load plug-ins.
AngelConfigurer configureServer(FileSystem fileSystem) {
  return (Angel app) async {
    // Load configuration from the `config/` directory.
    //
    // See: https://github.com/angel-dart/configuration
    await app.configure(configuration(fileSystem));

    // conect to mySql
    app
      ..container.registerSingleton<StorePatternService>(
          app.container.make<StorePatternServiceImpl>());
    await app.mountController<StorePatternController>();
  };
}
