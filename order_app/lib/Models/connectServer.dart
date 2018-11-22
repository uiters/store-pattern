import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import './../Constants/evn.dart';

class MySqlConnection{


  MySqlConnection._();
  static final instance = new MySqlConnection._();

  String token;
  final secretKey = new Hmac(sha256, utf8.encode('flutter'));

  Future<List> executeQuery(String query, {List parameter}) async  {
    if(parameter != null)
      query = _addParameter(query, parameter);

    var respone = await http.post(
      URL_EXECUTE,
      headers:{ ID_TOKEN : _encode(token)},
      body: {ID_EXECUTEQUERY : _encode(query)},
    );

    if(respone.statusCode == 200) //OK
      return [
        200,//satus
        json.decode(respone.body)
      ];//ok
    else if(respone.statusCode == 401) // Unauthorized
      return [401]; // unauthorized
    else throw Exception('Not identify');
  }

  Future<Map> login({String user, String pass, String token}) async  {
    if(token == null){
      Map<String, dynamic> data = {};
      data['user'] = user;
      data['pass'] = pass;

      String jsonLogin = json.encode(data);
      String encode = _encode(jsonLogin);
      var respone = await http.post(
        URL_LOGIN,
        headers: {ID_LOGIN : encode}
      );
      return _getValueLogin(respone);
    }
    else{
      String encode = _encode(token);
      var respone = await http.post(
        URL_LOGIN,
        body: {ID_LOGIN : encode}
      );
      return _getValueLogin(respone);
    }
  }

  Map _getValueLogin(http.Response respone) {
    if(respone.statusCode == 200)
    {
        Map<String, dynamic> data = json.decode(respone.body);
        token = data['Token'];
        return data;
    }
      else
        return json.decode("{'status' : '401'}");
  }


  Future<int> excecuteNoneQuery(String query, {List parameter}) async {
    if(parameter != null)
      query = _addParameter(query, parameter);

    var respone = await http.post(
      URL_EXECUTE,
      headers:{ ID_TOKEN : _encode(token) },
      body: {ID_EXECUTENONEQUERY : _encode(query) },
    );

    int number = 0;
    if(respone.statusCode == 200) //OK
      number = int.parse(respone.body);
    else if(respone.statusCode == 401) // Unauthorized
      number = -99;
    else throw Exception('Not identify');

    return number;
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