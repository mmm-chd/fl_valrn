import 'dart:convert';

import 'package:fl_valrn/configs/constant_api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.LOGIN}'),
    );

    request.fields['email'] = email;
    request.fields['password'] = password;

    final response = await request.send();
    final body = await response.stream.bytesToString();

    final result = jsonDecode(body);

    if (result['token'] != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', result['token']);
    }

    return result;
  }

  static Future<Map<String, dynamic>> register({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    required String confirmPassword,
  }) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.REGISTER}'),
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

  static Future<Map<String, dynamic>> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      return {'success': true, 'message': 'Sudah logout'};
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.LOGOUT}'),
    );

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    final response = await request.send();
    final body = await response.stream.bytesToString();

    await prefs.remove('token');

    return jsonDecode(body);
  }

  static Future<Map<String, dynamic>> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('${ConstantApi.FULL_URL}/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (body['user'] != null) {
        return body['user'];
      }
      throw Exception('User data not found');
    } else {
      throw Exception(body['message'] ?? 'Failed to fetch profile');
    }
  }
}
