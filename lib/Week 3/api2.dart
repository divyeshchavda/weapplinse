import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  // Base URL of the API
  static const String _baseUrl = 'http://192.168.1.2/blog/api';

  // Add user method
  static Future<dynamic> addUser({
    required String name,
    required String email,
    required File profilePic,
  }) async {
    final Uri url = Uri.parse('$_baseUrl/add_user');

    // Define headers
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer YOUR_TOKEN', // Add if required
    };

    // Create the request body
    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['name'] = name
      ..fields['email'] = email
      ..files.add(await http.MultipartFile.fromPath(
        'profile_pic',
        profilePic.path,
      ));

    // Send the request
    final streamedResponse = await request.send();
    if(streamedResponse.statusCode==200){
      print('User Added Successfully');
    }else
    {
      print("Failed to Add User");
    }

  }
  static Future<List<dynamic>> getUserList() async {
    final url=Uri.parse("$_baseUrl/get_user_list");
    final response = await http.get(url);
    if(response.statusCode==200){
      return json.decode(response.body)['data'];
    }
    else
      {throw Exception('Error 404');}
  }

  // Edit user details
  static Future<http.Response> editUser({
    required String userId,
    required String name,
    required String email,
    required File profilePic,
  }) async {
    final Uri url = Uri.parse('$_baseUrl/edit_user_details');

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer YOUR_TOKEN', // Add if required
    };

    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['user_id'] = userId
      ..fields['name'] = name
      ..fields['email'] = email
      ..files.add(await http.MultipartFile.fromPath(
        'profile_pic',
        profilePic.path,
      ));
    final streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }
}
