import 'dart:convert';

import 'package:fl_valrn/configs/constant_api.dart';
import 'package:fl_valrn/model/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  static Future<ProfileModel> getProfile (int userId) async{
    final prefs= await SharedPreferences.getInstance();
    final token= prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found, please login');
    }

    final response = await http.get(
      Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.PROFILE}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return ProfileModel.fromJson(body);
    } else {
      throw Exception('Failed to load profile');
    }
  
  }

   static Future<bool> updateProfile(int userId, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found, please login');
    }

    final response = await http.put(
      Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.PROFILE}$userId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    return response.statusCode == 200;
  }
}