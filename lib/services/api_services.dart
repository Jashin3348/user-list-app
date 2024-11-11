

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_list_app/models/user.dart';

class ApiServices {
    static const String apiUrl = 'https://jsonplaceholder.typicode.com/users';
Future<List<User>> fetchUsers()async{
  final response = await http.get(Uri.parse(apiUrl));
  if(response.statusCode==200){
    List<dynamic> data=jsonDecode(response.body);
    return data.map((json)=>User.fromJson(json)).toList();
  }
  else{
    throw Exception('failed to load users');
  }
}

}