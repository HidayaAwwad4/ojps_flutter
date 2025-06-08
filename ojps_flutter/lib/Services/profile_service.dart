import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<Map<String, dynamic>?> _getUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson == null) return null;
    return jsonDecode(userJson);
  }
  Future<bool> updateProfile(Map<String, dynamic> updatedData) async {
    final url = Uri.parse('$baseUrl/user/profile');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['status'] == true;
      }
      return false;
    } catch (e) {
      print('Error updating profile: $e');
      return false;
    }
  }

  Future<bool> updateBasicInfo({
    required String name,
    required String email,
    required String summary,
  }) async {
    final url = Uri.parse('$baseUrl/seeker/profile/basic');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'summary': summary,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['status'] == true;
      }
      return false;
    } catch (e) {
      print('Error updating basic info: $e');
      return false;
    }
  }


  Future<bool> uploadProfilePicture(String filePath) async {
    final url = Uri.parse('$baseUrl/user/profile/picture');

    try {
      final request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath('profile_picture', filePath));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['status'] == true;
      }
      return false;
    } catch (e) {
      print('Error uploading profile picture: $e');
      return false;
    }
  }

  Future<bool> uploadResume(String filePath) async {
    final url = Uri.parse('$baseUrl/user/resume');

    try {
      final request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath('resume', filePath));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['status'] == true;
      }
      return false;
    } catch (e) {
      print('Error uploading resume: $e');
      return false;
    }
  }

  Future<bool> updatePassword(String currentPassword, String newPassword) async {
    final url = Uri.parse('$baseUrl/user/update-password');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'current_password': currentPassword,
          'new_password': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['status'] == true;
      }
      return false;
    } catch (e) {
      print('Error updating password: $e');
      return false;
    }
  }

  Future<int?> fetchJobSeekerId() async {
    final userMap = await _getUserFromPrefs();
    if (userMap == null) return null;
    final userId = userMap['id'];

    final url = Uri.parse('$baseUrl/job-seekers/user/$userId');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['job_seeker_id'];
      }
      return null;
    } catch (e) {
      print('Error fetching Job Seeker ID: $e');
      return null;
    }
  }

  Future<http.Response?> downloadResume(int jobSeekerId) async {
    final url = Uri.parse('$baseUrl/job-seekers/$jobSeekerId/resume');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return response;
      }
      return null;
    } catch (e) {
      print('Error downloading resume: $e');
      return null;
    }
  }
}
