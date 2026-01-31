import 'dart:convert';
import 'package:fl_valrn/configs/constant_api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AnalysisService {
  /// POST /api/v1/analyses
  /// Body: JSON raw dengan structure seperti di gambar
  static Future<bool> createAnalysis({
    required int analyzeJournalId,
    required List<String> images, // ["analyses/image1.jpg", "analyses/image2.jpg"]
    required String plantCommonName,
    required String plantScientificName,
    required String healthStatus,
    required double healthConfidence,
    required String healthUrgency,
    required String diagnosis,
    required List<String> recommendations,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) throw Exception('Token not found, please login');

    final body = {
      "analyze_journal_id": analyzeJournalId,
      "images": images,
      "plant_common_name": plantCommonName,
      "plant_scientific_name": plantScientificName,
      "health_status": healthStatus,
      "health_confidence": healthConfidence,
      "health_urgency": healthUrgency,
      "analysis": {
        "diagnosis": diagnosis,
        "recommendations": recommendations,
      }
    };

    try {
      final response = await http.post(
        Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.API_VERSION}/analyses'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('Error creating analysis: $e');
      return false;
    }
  }

  /// GET /api/v1/analyses (jika perlu fetch data analyses)
  static Future<List<dynamic>> fetchAnalyses() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) throw Exception('Token not found, please login');

    final response = await http.get(
      Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.API_VERSION}/analyses'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'] ?? [];
    } else {
      throw Exception('Failed to load analyses');
    }
  }
}