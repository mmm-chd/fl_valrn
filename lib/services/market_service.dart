// lib/services/market_service.dart

import 'dart:convert';

import 'package:fl_valrn/configs/constant_api.dart';
import 'package:fl_valrn/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MarketService {
  /// Get all products
  static Future<List<ProductItem>> getProducts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token not found, please login');
      }

      final url = '${ConstantApi.FULL_URL}${ConstantApi.PRODUCT}';
      print('🌐 Fetching products from: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      print('📊 STATUS CODE: ${response.statusCode}');
      print('📦 RESPONSE BODY: ${response.body}');

      if (response.statusCode == 200) {
        try {
          final dynamic decodedBody = jsonDecode(response.body);

          if (decodedBody is! List) {
            print('❌ Response bukan List, tipe: ${decodedBody.runtimeType}');
            throw Exception(
              'Response format invalid: expected List, got ${decodedBody.runtimeType}',
            );
          }

          final List body = decodedBody;
          print('✅ Total products: ${body.length}');

          List<ProductItem> products = [];
          for (int i = 0; i < body.length; i++) {
            try {
              final product = ProductItem.fromJson(body[i]);
              products.add(product);
              print('✅ Product $i parsed: ${product.title}');
            } catch (e) {
              print('❌ Error parsing product $i: $e');
              print('📄 Product data: ${body[i]}');
            }
          }

          if (products.isEmpty) {
            throw Exception('No valid products found');
          }

          return products;
        } catch (e) {
          print('❌ Error decoding JSON: $e');
          rethrow;
        }
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Token mungkin sudah kadaluarsa');
      } else {
        throw Exception(
          'Failed to load products: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('❌ ERROR IN getProducts: $e');
      rethrow;
    }
  }
}
