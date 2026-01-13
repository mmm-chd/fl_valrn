import 'dart:convert';

import 'package:http/http.dart' as http;

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

    return jsonDecode(body);
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
}