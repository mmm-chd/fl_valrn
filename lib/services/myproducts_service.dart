import 'dart:convert';

import 'package:fl_valrn/configs/constant_api.dart';
import 'package:fl_valrn/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyproductsService {
  static Future<List<ProductItem>> getMyProducts(int userId) async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found, please login');
    }

    final response = await http.get(
      Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.MYPRODUCT}$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
      },
    );

    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    if (response.statusCode == 200) {
      final List body= jsonDecode(response.body);

      return body
        .where((e) => e != null)
        .map((e) => ProductItem.fromJson(e as Map<String, dynamic>))
        .toList();
    } else{
      throw Exception ('Failed to load products');
    }
  }
}