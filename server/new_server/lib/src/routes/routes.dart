library store_pattern_service.src.routes;

import 'package:angel_framework/angel_framework.dart';
import 'package:file/file.dart';
import 'controllers/controllers.dart' as controllers;

/// Put your app routes here!
///
/// See the wiki for information about routing, requests, and responses:
/// * https://github.com/angel-dart/angel/wiki/Basic-Routing
/// * https://github.com/angel-dart/angel/wiki/Requests-&-Responses
AngelConfigurer configureServer(FileSystem fileSystem) {
  return (Angel app) async {
    // Typically, you want to mount controllers first, after any global middleware.
    await app.configure(controllers.configureServer);

    // Render `views/hello.jl` when a user visits the application root.
    app.get('/', (req, res) => res.json({'data': 'Hello 😍'}));

    // Throw a 404 if no route matched the request.
    app.fallback((req, res) => res.json({'data': 'Not found 😭'}));

    // Set our application up to handle different errors.
    //
    // Read the following for documentation:
    // * https://github.com/angel-dart/angel/wiki/Error-Handling

    app.errorHandler = (e, req, res) {
      res.statusCode = e.statusCode;
      return res.json({
        'error': true,
        'status': e.statusCode,
        'message': 'Are you kidding me? 👍',
      });
    };
  };
}
