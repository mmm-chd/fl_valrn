import 'dart:convert';
import 'package:http/http.dart' as http;

class PlantAIService {
  static const String _endpoint = 'http://192.168.110.225:8000/api/v1/plant/analyze';

  static Future<Map<String, dynamic>> analyzePlant({
    required String imagePath,
  }) async {
    final uri = Uri.parse(_endpoint);
    final request = http.MultipartRequest('POST', uri);

    request.files.add(
      await http.MultipartFile.fromPath('image', imagePath),
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

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    print('=== API RESPONSE ===');
    print('Status Code: ${response.statusCode}');
    print('Response Body: $responseBody');
    print('==================');

    if (response.statusCode != 200) {
      throw Exception('API Error ${response.statusCode}: $responseBody');
    }

    final jsonResponse = json.decode(responseBody);
    
    print('=== PARSED JSON ===');
    print(jsonResponse);
    print('==================');

    return jsonResponse;
  }
}
