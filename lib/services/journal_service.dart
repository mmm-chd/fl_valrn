import 'dart:convert';
import 'package:fl_valrn/configs/constant_api.dart';
import 'package:fl_valrn/model/journal_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class JournalService {
  static Future<List<Journal>> fetchJournals() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found, please login');
    }
    final response = await http.get(
      Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.JOURNALS}'),
      headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final journalsJson = data['data']['journals'] as List;
      return journalsJson.map((e) => Journal.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load journals');
    }
  }
}