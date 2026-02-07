import 'dart:convert';

import 'package:fl_valrn/configs/constant_api.dart';
import 'package:fl_valrn/model/auth/login_model.dart';
import 'package:fl_valrn/model/auth/logout_model.dart';
import 'package:fl_valrn/model/auth/profile_model.dart';
import 'package:fl_valrn/model/auth/register_model.dart';
import 'package:fl_valrn/model/auth/reset_password_model.dart';
import 'package:fl_valrn/model/auth/send_otp_model.dart';
import 'package:fl_valrn/model/auth/update_profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = await http.post(
        Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.LOGIN}'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      final body = loginModelFromJson(result.body);
      if (result.statusCode == 200) {
        if (body.token != null && body.token.isNotEmpty) {
          await prefs.setString('token', body.token);
        }
        print('Token: ${body.token}');
        print(body.message);
        return body;
      } else {
        print("error : ${body.message}");
        throw Exception(body.message);
      }
    } catch (e) {
      print('❌ Error in login: $e');
      rethrow;
    }
  }

  static Future<RegisterModel> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final result = await http.post(
        Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.REGISTER}'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': '$firstName $lastName',
          'email': email,
          'phone': phone,
          'password': password,
          'password_confirmation': confirmPassword,
        }),
      );
      if (result.statusCode == 200) {
        final body = registerModelFromJson(result.body);
        print(body.message);
        return body;
      } else {
        final body = registerModelFromJson(result.body);
        print(body.message);
        throw Exception(body.message);
      }
    } catch (e) {
      print('❌ Error in register: $e');
      rethrow;
    }
  }

  static Future<LogoutModel> logout() async {
    try {
      final token = await _getToken();
      final result = await http.post(
        Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.LOGOUT}'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (result.statusCode == 200) {
        final body = logoutModelFromJson(result.body);
        print(body.message);
        clearStorage();
        return body;
      } else {
        throw Exception('Failed to logout');
      }
    } catch (e) {
      print('❌ Error in logout: $e');
      rethrow;
    }
  }

  static Future<ProfileModel> profile() async {
    try {
      final token = await _getToken();
      final response = await http.get(
        Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.PROFILE}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      final body = profileModelFromJson(response.body);
      if (response.statusCode == 200) {
        print(body.message);
        return body;
      } else {
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      print('❌ Error in profile: $e');
      rethrow;
    }
  }

  static Future<SendOtpModel> sendOtp({required String email}) async {
    try {
      final token = await _getToken();
      final response = await http.post(
        Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.SEND_OTP}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email}),
      );
      final body = sendOtpModelFromJson(response.body);
      if (response.statusCode == 200) {
        print(body.message);
        return body;
      } else {
        throw Exception('Failed to send otp');
      }
    } catch (e) {
      print('❌ Error: $e');
      rethrow;
    }
  }

  static Future<ResetPasswordModel> resetPassword({
    required String email,
    required int otp,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final token = await _getToken();
      final response = await http.post(
        Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.RESET_PASSWORD}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'otp': otp,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );
      final body = resetPasswordModelFromJson(response.body);
      if (response.statusCode == 200) {
        print(body.message);
        return body;
      } else {
        throw Exception('Failed to reset password');
      }
    } catch (e) {
      print('❌ Error: $e');
      rethrow;
    }
  }

  static Future<UpdateProfileModel> updateProfile({
    required String name,
    required String email,
    required String description,
    required String phone,
    required String instagram,
    required String facebook,
  }) async {
    try {
      final token = await _getToken();
      final response = await http.put(
        Uri.parse('${ConstantApi.FULL_URL}${ConstantApi.UPDATE_PROFILE}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'phone': phone,
          'description': description,
          'instagram': instagram,
          'facebook': facebook,
        }),
      );

      if (response.statusCode == 200) {
        final body = updateProfileModelFromJson(response.body);
        print(body.message);
        return body;
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      print('❌ Error: $e');
      rethrow;
    }
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null;
  }

  /// Get stored token
  static Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      return token;
    } else {
      throw Exception('No authentication token found. Please login again.');
    }
  }

  /// Clear all stored data
  static Future<void> clearStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
