import 'dart:convert';

import 'package:fl_valrn/configs/constant_api.dart';
import 'package:fl_valrn/model/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // ==================== AUTH METHODS ====================

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      print('🔐 Attempting login for: $email');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.LOGIN}'),
      );

      request.fields['email'] = email;
      request.fields['password'] = password;

      final response = await request.send();
      final body = await response.stream.bytesToString();

      print('📊 Login Status Code: ${response.statusCode}');
      print('📦 Login Response: $body');

      final result = jsonDecode(body);

      if (result['token'] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', result['token']);
        print('✅ Token saved successfully');
      }

      return result;
    } catch (e) {
      print('❌ Error in login: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> register({
    required String email,
    required String phone,
    required String firstName,
    required String lastName,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      print('📝 Attempting registration for: $email');

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.REGISTER}'),
      );

      request.fields.addAll({
        'name': '$firstName $lastName',
        'email': email,
        'phone': phone,
        'password': password,
        'password_confirmation': confirmPassword,
      });

      final response = await request.send();
      final body = await response.stream.bytesToString();

      print('📊 Register Status Code: ${response.statusCode}');
      print('📦 Register Response: $body');

      return jsonDecode(body);
    } catch (e) {
      print('❌ Error in register: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> logout() async {
    try {
      print('🚪 Attempting logout...');

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        print('⚠️ No token found, already logged out');
        return {'success': true, 'message': 'Sudah logout'};
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.LOGOUT}'),
      );

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      final response = await request.send();
      final body = await response.stream.bytesToString();

      print('📊 Logout Status Code: ${response.statusCode}');

      // Remove token regardless of response
      await prefs.remove('token');
      print('✅ Token removed successfully');

      return jsonDecode(body);
    } catch (e) {
      print('❌ Error in logout: $e');
      // Remove token even if request fails
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      rethrow;
    }
  }

  // ==================== PROFILE METHODS ====================

  /// Get user profile (returns raw Map for backward compatibility)
  static Future<Map<String, dynamic>> getProfile() async {
    try {
      print('👤 Fetching user profile...');

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token not found');
      }

      final response = await http.get(
        Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.PROFILE}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print('📊 Profile Status Code: ${response.statusCode}');
      print('📦 Profile Response: ${response.body}');

      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (body['user'] != null) {
          print('✅ Profile fetched successfully');
          return body['user'];
        }
        throw Exception('User data not found');
      } else {
        throw Exception(body['message'] ?? 'Failed to fetch profile');
      }
    } catch (e) {
      print('❌ Error in getProfile: $e');
      rethrow;
    }
  }

  /// Get user profile as ProfileModel object
  static Future<ProfileModel> getProfileModel() async {
    try {
      print('👤 Fetching user profile as model...');

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token not found, please login');
      }

      final url = '${ConstantApi.FULL_URL}${ConstantApi.PROFILE}';
      print('🌐 Fetching profile from: $url');

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
        final ProfileResponse profileResponse = ProfileResponse.fromJson(
          jsonDecode(response.body),
        );

        print('✅ Profile loaded: ${profileResponse.user.name}');
        return profileResponse.user;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Token mungkin sudah kadaluarsa');
      } else {
        final body = jsonDecode(response.body);
        throw Exception(
          body['message'] ?? 'Failed to load profile: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('❌ ERROR IN getProfileModel: $e');
      rethrow;
    }
  }

  /// Update user profile
  static Future<ProfileModel> updateProfile({
    String? name,
    String? email,
    String? phone,
    String? instagram,
    String? facebook,
    String? description,
  }) async {
    try {
      print('✏️ Updating user profile...');

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token not found, please login');
      }

      final url = '${ConstantApi.FULL_URL}${ConstantApi.PROFILE}';
      print('🌐 Updating profile at: $url');

      // Build request body - hanya kirim field yang diisi
      final Map<String, dynamic> body = {};
      if (name != null) body['name'] = name;
      if (email != null) body['email'] = email;
      if (phone != null) body['phone'] = phone;
      if (instagram != null) body['instagram'] = instagram;
      if (facebook != null) body['facebook'] = facebook;
      if (description != null) body['description'] = description;

      print('📤 Request body: $body');

      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      print('📊 STATUS CODE: ${response.statusCode}');
      print('📦 RESPONSE BODY: ${response.body}');

      if (response.statusCode == 200) {
        final ProfileResponse profileResponse = ProfileResponse.fromJson(
          jsonDecode(response.body),
        );

        print('✅ Profile updated: ${profileResponse.user.name}');
        return profileResponse.user;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Token mungkin sudah kadaluarsa');
      } else if (response.statusCode == 422) {
        // Validation error
        final error = jsonDecode(response.body);
        throw Exception(
          'Validation error: ${error['message'] ?? 'Invalid data'}',
        );
      } else {
        final error = jsonDecode(response.body);
        throw Exception(
          error['message'] ??
              'Failed to update profile: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('❌ ERROR IN updateProfile: $e');
      rethrow;
    }
  }

  /// Change password
  static Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      print('🔑 Changing password...');

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token not found, please login');
      }

      // Sesuaikan dengan endpoint API Anda
      final url = '${ConstantApi.FULL_URL}/change-password';
      print('🌐 Changing password at: $url');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'old_password': oldPassword,
          'password': newPassword,
          'password_confirmation': confirmPassword,
        }),
      );

      print('📊 STATUS CODE: ${response.statusCode}');
      print('📦 RESPONSE: ${response.body}');

      if (response.statusCode == 200) {
        print('✅ Password changed successfully');
        return true;
      } else if (response.statusCode == 401) {
        throw Exception('Password lama tidak sesuai');
      } else if (response.statusCode == 422) {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Validation error');
      } else {
        final error = jsonDecode(response.body);
        throw Exception(
          error['message'] ??
              'Failed to change password: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('❌ ERROR IN changePassword: $e');
      rethrow;
    }
  }

  // ==================== HELPER METHODS ====================

  /// Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null;
  }

  /// Get stored token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  /// Clear all stored data
  static Future<void> clearStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print('✅ Storage cleared');
  }
}
