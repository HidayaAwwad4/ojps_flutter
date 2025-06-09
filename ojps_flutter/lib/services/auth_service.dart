import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String apiUrl = 'http://10.0.2.2:8000/api';


  Future<http.Response> getRoles() async {
    return await http.get(Uri.parse('$apiUrl/roles'));
  }


  Future<http.Response> register(Map<String, dynamic> data) async {
    return await http.post(
      Uri.parse('$apiUrl/register'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },

      body: jsonEncode(data),
    );
  }


  Future<http.Response> login(Map<String, dynamic> data) async {
    return await http.post(
      Uri.parse('$apiUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  }


  Future<http.Response> getProfile(String token) async {
    return await http.get(
      Uri.parse('$apiUrl/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }


  Future<http.Response> logout(String token) async {
    return await http.post(
      Uri.parse('$apiUrl/logout'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }


  Future<http.Response> forgotPassword(String email) async {
    return await http.post(
      Uri.parse('$apiUrl/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
  }


  Future<http.Response> verifyForgotCode(String email, String code) async {
    return await http.post(
      Uri.parse('$apiUrl/verify-forgot-code'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'verification_code': code}),
    );
  }


  Future<http.Response> resetPassword(String email, String password, String confirmPassword) async {
    return await http.post(
      Uri.parse('$apiUrl/reset-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword
      }),
    );
  }
}