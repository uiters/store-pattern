import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import './../Constants/evn.dart';

class MySqlConnection{


  MySqlConnection._();
  static final instance = new MySqlConnection._();

  String token = '71140d8cfef118324a2fa9218b958c6f02b5f83e6810fb8c665f0cd7ef919043';
  final secretKey = new Hmac(sha256, utf8.encode('flutter'));

  Future<dynamic> executeQuery(String query, {List parameter}) async  {
    if(parameter != null)
      query = _addParameter(query, parameter);
    String code = _encode(token);
    print(code);
    String query1 = _encode(query);
    print(query1);

    var respone = await http.post(
      URL_EXECUTE,
      headers:{ ID_TOKEN : code},
      body: {ID_EXECUTEQUERY : query1},
    );
    if(respone.statusCode == 200) //OK
      return json.decode(respone.body);
    else return null;
  }

  Future<bool> excecuteNoneQuery(String query, {List parameter}) async {
    if(parameter != null)
      query = _addParameter(query, parameter);

    String code = _encode(token);
    print(code);
    String query1 = _encode(query);
    print(query1);

    var respone = await http.post(
      URL_EXECUTE,
      headers:{ ID_TOKEN : code },
      body: {ID_EXECUTENONEQUERY : query1 },
    );

    int number = 0;
    if(respone.statusCode == 200) //OK
      number = int.parse(respone.body);
    return number > 0;
  }

  String _encode(String str)
  {
    String header = base64.encode(utf8.encode(str));
    String signature = secretKey.convert(utf8.encode(header)).toString();
    return header + '.' + signature;
  }

  String _addParameter(String query, List parameter) {
    /**To return a query have added paramete ralready
     * 
     * query = "call USP_Proc( @a , @b , @c )"
     * 
     *  parameter = ["123" , "123" , 123 ]
     * 
     *  After call  addParameter
     * so result query = "call USP_Proc( '123' , '123' , 123 )"
     * */
    List<String> list = query.split(' ');
    query = "";
    int i = 0;
    list.forEach((String element) {
      if (element.contains('@')){
        if ((parameter[i] is String || parameter[i] is DateTime) && parameter.length > i)
          query +=  "\'" + parameter[i++].toString() +"\'";
        else query += parameter[i++].toString();
      }
        else query += element;
      query += " ";
      });
    return query;
  }
}