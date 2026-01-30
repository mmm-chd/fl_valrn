import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const baseUrl= 'https://waysa.rplrus.com/api';

  static Future<Map<String, dynamic>>  login({
    required String email,
    required String password,
  })async {
    var request = http.MultipartRequest(
      'POST', 
      Uri.parse('$baseUrl/login')
    );

    request.fields['email']= email;
    request.fields['password']= password;

    final response = await request.send();
    final body = await response.stream.bytesToString();

    final result= jsonDecode(body);

    if (result['token'] != null) {
      final prefs= await SharedPreferences.getInstance();
      await prefs.setString('token', result['token']);
    }

    return result;
  }

  static Future<Map<String, dynamic>> register ({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    required String confirmPassword,
  }) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl}/register'),
    );

      request.fields.addAll({
      'name': '$firstName $lastName',
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
    });

    final response = await request.send();
    final body = await response.stream.bytesToString();

    return jsonDecode(body);
  }

  static Future<Map<String, dynamic>>  logout() async{
    final prefs = await SharedPreferences.getInstance();
    final token= prefs.getString('token');

    if (token == null) {
      return {
        'success': true,
        'message': 'Sudah logout'
      };
    }

    var request= http.MultipartRequest(
      'POST', 
      Uri.parse('$baseUrl/logout'),
    );

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    });

    final response = await request.send();
    final body = await response.stream.bytesToString();

    await prefs.remove('token');

    return jsonDecode(body);

  }

  static Future<Map<String, dynamic>> getProfile() async {
    final prefs= await SharedPreferences.getInstance();
    final token= prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    final response= await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      }
    );

    if (response.statusCode== 200) {
      return jsonDecode(response.body);
    }else {
      throw Exception('Failde to fetch profile');
    }
  }
}