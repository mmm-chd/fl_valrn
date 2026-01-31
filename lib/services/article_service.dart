import 'dart:convert';

import 'package:fl_valrn/configs/constant_api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ArticleService {
  // Fungsi untuk mendapatkan semua artikel
  static Future<List<dynamic>> getAllArticles() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      throw Exception('User not logged in');
    }

    final uri = Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.ARTICLE_LIST}');

    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to load articles: ${response.statusCode}');
    }

    final jsonResponse = json.decode(response.body);

    if (jsonResponse is List) {
      return jsonResponse;
    } else {
      throw Exception('Unexpected response format');
    }
  }

  static Future<Map<String, dynamic>> getArticleById(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      throw Exception('User not logged in');
    }

    final uri = Uri.parse(
      '${ConstantApi.FULL_URL}${ConstantApi.API_VERSION}${ConstantApi.ARTICLE_LIST}/$id',
    );

    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to load article');
    }

    final jsonResponse = json.decode(response.body);
    return jsonResponse as Map<String, dynamic>;
  }
}
