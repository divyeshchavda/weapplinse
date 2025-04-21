import 'dart:convert';
import 'dart:io';

import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
class api{
  static const String baseurl="http://192.168.29.42/blog/api";
  static Future<dynamic> add({required String name,required String email,required File pic}) async{
    var url = Uri.parse('$baseurl/add_user');
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer YOUR_TOKEN', // Add if required
    };
    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['name']=name
      ..fields['email']=email
      ..files.add(await http.MultipartFile.fromPath('profile_pic',pic.path ));
    var response=await request.send();
    if(response.statusCode==200){
      print('User Added Successfully');
    }else
      {
        print("Failed to Add User");
      }
  }
  static Future<List<dynamic>> fetch() async {
    final url=Uri.parse('$baseurl/get_user_list');
    final response=await http.get(url);
    if(response.statusCode==200){
      return json.decode(response.body)['data'];
    }
    else{
      throw Exception('Failed to load users');
    }
  }
  static Future<dynamic> edit({
    required String Id,
    required String name,
    required String email,
    File? pic,
  }) async {
    var url = Uri.parse('$baseurl/edit_user_details');
    Map<String, String> headers = {
      'Authorization': 'Bearer YOUR_TOKEN', // Add if required
    };

    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['user_id'] = Id
      ..fields['name'] = name
      ..fields['email'] = email;

    if (pic != null) {
      request.files.add(await http.MultipartFile.fromPath('profile_pic', pic.path));
    }

    var response = await request.send();
    return await http.Response.fromStream(response);
  }


  static Future<void> delete({required String id}) async {
    final url = Uri.parse('$baseurl/delete_user');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({'user_id': id}),
    );

    if (response.statusCode == 200) {
      print("Deleted Successfully");
    } else {
      print("Failed to Delete: ${response.body}");
    }
  }
  static Future<List<dynamic>> fetch2({required int page, required int limit}) async {
    final url = Uri.parse('$baseurl/get_user_list?page=$page&limit=$limit');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body)['data']; // Extract 'data' from the response
    } else {
      throw Exception('Failed to load users');
    }
  }
}