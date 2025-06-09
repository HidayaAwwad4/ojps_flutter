import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/job_seeker.dart';

class JobSeekerService {
  final String baseUrl = 'http://10.0.2.2:8000/api';
/*
  Future<Map<String, dynamic>?> _getUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson == null) return null;
    return jsonDecode(userJson);
  }
*/
  Future<JobSeeker?> getJobSeekerProfile() async {
    /*final userMap = await _getUserFromPrefs();
    if (userMap == null) {
      print('No user data found in SharedPreferences');
      return null;
    }
    int userId = userMap['id'];
    final jobSeekerId = await _fetchJobSeekerId(userId);
    if (jobSeekerId == null) {
      print('JobSeeker ID not found for user id: $userId');
      return null;
    }
*/
    //final url = Uri.parse('$baseUrl/job-seekers/$jobSeekerId');
      final url = Uri.parse('$baseUrl/job-seekers/1');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == true && responseData['data'] != null) {
          return JobSeeker.fromJson(responseData['data']);
        } else {
          print('API returned error or no data');
          return null;
        }
      } else {
        print('Failed to load JobSeeker profile. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching JobSeeker profile: $e');
      return null;
    }
  }

  Future<int?> _fetchJobSeekerId(int userId) async {
    final url = Uri.parse('$baseUrl/job-seekers/user/$userId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['job_seeker_id'];
      } else {
        print('Failed to fetch JobSeeker ID. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching JobSeeker ID: $e');
      return null;
    }
  }
}
