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
      Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.API_VERSION}${ConstantApi.JOURNALS}'),
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

  static Future<bool> createJournal({
    required String title,
    required String description,
    String? imageUrl,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) throw Exception('Token not found');

    final response = await http.post(
      Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.API_VERSION}${ConstantApi.JOURNALS}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: {
        'title': title,
        'description': description,
        'image': imageUrl ?? '',
      },
    );

    return response.statusCode == 200 || response.statusCode == 201;
}

  static Future<bool> updateJournal({
  required int id,
  String? title,
  String? description,
  String? imageUrl,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  if (token == null) throw Exception('Token not found, please login');

  final body = {
    'id': id, // wajib kirim ID karena endpoint tanpa /$id
    'title': title ?? 'Updated Title',
    'description': description ?? 'Updated Desc',
    'image': imageUrl ?? '',
  };

  final response = await http.put(
    Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.API_VERSION}${ConstantApi.JOURNALS}'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode(body),
  );

  return response.statusCode == 200;
}

}