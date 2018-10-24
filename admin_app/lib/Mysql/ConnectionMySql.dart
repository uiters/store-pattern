//library mysqlconnection;
import 'package:http/http.dart' as http;
import '../Constant/constant.dart';
import 'dart:async';
import 'dart:convert';

class MySqlConnection{

  static MySqlConnection _instance;

  static MySqlConnection get instance {
    if(_instance == null) _instance = new MySqlConnection();
    return _instance;
  }

    ///executeNoneQuery without or with parameter
    ///
    ///return Future<bool>
  Future<bool> executeNoneQuery(String query, {List parameter}) async {

    if(parameter != null)
      query = _addParameter(query,  parameter);
    http.Response response = await http.post(
      URL_EXECUTE,
      body : { ID_EXECUTENONEQUERY : query },
    );
    int number = 0;
    if(response.statusCode == 200)
      number = int.parse(response.body);
    return number > 0;
  }


    ///executeNoneQuery without or with parameter
    ///
    ///return Future<List>
  Future<List> executeQuery(String query, {List parameter}) async {

    if(parameter != null)
      query = _addParameter(query,  parameter);
    http.Response response = await http.post(
      URL_EXECUTE,
      body : { ID_EXECUTENONEQUERY : query },
    );
    List listObject;

    if(response.statusCode == 200)
      listObject = json.decode(response.body);
    else listObject = null;

    return listObject;
  }

  static String _addParameter(String query, List parameter) {
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
        if(parameter[i] is String)
          query +=  "\'" + parameter[i++] +"\'";
        else query += parameter[i++].toString();
      }
        else query += element;
      query += " ";
    });
    return query;
  }

}

