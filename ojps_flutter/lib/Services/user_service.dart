import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static Future<Map<String, dynamic>> getProfile(String token) async {
    final response = await http.get(
      Uri.parse('https://yourdomain.com/api/user/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load profile');
    }
  }

  static Future<Map<String, dynamic>> getResume(String token) async {
    final response = await http.get(
      Uri.parse('https://yourdomain.com/api/user/resume'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load resume');
    }
  }

}
