import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PlantAIService {

  static const String BASE_URL = 'https://waysa.rplrus.com';
  static final String _endpoint = '$BASE_URL/api/v1/plant/analyze';

  static Future<Map<String, dynamic>> analyzePlant({
    required String imagePath,
  }) async {

    //get token
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      throw Exception('User not logged in');
    }

    final uri = Uri.parse(_endpoint);
    final request = http.MultipartRequest('POST', uri);

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imagePath,
      ),
    );

    request.fields['language'] = 'id';
    request.fields['detail_level'] = 'standard';

    final focusAreas = [
      'identification',
      'characteristics',
      'care',
      'growing',
      'health',
      'uses',
      'warnings',
    ];

    for (int i = 0; i < focusAreas.length; i++) {
      request.fields['focus_areas[$i]'] = focusAreas[i];
    }

    // send
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    print('Status: ${response.statusCode}');
    print('Body: $responseBody');

    if (response.statusCode != 200) {
      throw Exception(
        'API Error ${response.statusCode}: $responseBody',
      );
    }

    return json.decode(responseBody);
  }
}
