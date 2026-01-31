import 'dart:convert';

import 'package:fl_valrn/configs/constant_api.dart';
import 'package:fl_valrn/model/product_model.dart';
import 'package:http/http.dart' as http;

class MarketService {
  static Future<List<ProductItem>> getProducts() async {
    final response = await http.get(
      Uri.parse('${ConstantApi.FULL_URL}/products'),
      headers: {
        'Accept': 'application/json',
    },
    );

    if (response.statusCode == 200) {
      final body= jsonDecode(response.body);

      return body
          .map((e) => ProductItem.fromJson(e))
          .toList();
    } else{
      throw Exception ('Failed to load products');
    }
  }
}