import 'dart:async';

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_serialize/angel_serialize.dart';
import 'package:store_pattern_service/src/models/query_request.dart';
import 'package:store_pattern_service/src/services/store_pattern_service.dart';
import 'package:http_parser/http_parser.dart';

@Expose('/')
class StorePatternController extends Controller {
  final StorePatternService service;
  StorePatternController(this.service);

  @Expose('/', method: 'POST', middleware: [parseRequest])
  Future handleRequest(QueryRequest request, ResponseContext res) async {
    if (request.isNoneQuery) {
      return service.executeNoneQuery(request.query);
    } else {
      final value = await service.executeQuery(request.query);
      if (value != null) {
        final r = json.encode(value, toEncodable: dateTimeEncoder);
        res
          ..contentType = MediaType('application', 'json')
          ..write(r);
      } else {
        return 0;
      }
    }
  }
}

Future<bool> parseRequest(RequestContext req, ResponseContext res) async {
  return req.parseBody().then((_) {
    final query = QueryRequest.fromJson(req.bodyAsMap);
    req.params['request'] = query;
    req.params['res'] = res;
    return true;
  });
}

dynamic dateTimeEncoder(item) {
  print('item:: $item');
  if (item is DateTime) {
    return item.toIso8601String();
  }
  return item;
}
