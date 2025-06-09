import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdminService {
  final String baseUrl = 'http://10.0.2.2:8000/api';
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Map<String, String>> getHeaders() async {
    //final token = await getToken();
    final token = "55|gYVWaVoOnA7JfAAxAjOaPSWafBWSeHP9E9XRSVyUebfc1948";
    return {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
  }

  Future<List<dynamic>> getAllUsers({String? search}) async {
    final uri = Uri.parse('$baseUrl/admin/users').replace(queryParameters: {
      if (search != null && search.isNotEmpty) 'search': search,
    });
    final headers = await getHeaders();
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load users');
  }

  Future<dynamic> addUser(Map<String, dynamic> userData) async {
    final uri = Uri.parse('$baseUrl/admin/users');
    final headers = await getHeaders();
    final response = await http.post(
      uri,
      headers: {...headers, 'Content-Type': 'application/json'},
      body: json.encode(userData),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    }
    throw Exception('Failed to add user');
  }

  Future<dynamic> updateUser(int id, Map<String, dynamic> userData) async {
    final uri = Uri.parse('$baseUrl/admin/users/$id');
    final headers = await getHeaders();
    final response = await http.put(
      uri,
      headers: {...headers, 'Content-Type': 'application/json'},
      body: json.encode(userData),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to update user');
  }

  Future<void> deleteUser(int id) async {
    final uri = Uri.parse('$baseUrl/admin/users/$id');
    final headers = await getHeaders();
    final response = await http.delete(uri, headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }

  Future<List<dynamic>> getPendingEmployers() async {
    final uri = Uri.parse('$baseUrl/admin/employers/pending');
    final headers = await getHeaders();
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load pending employers');
  }

  Future<void> approveEmployer(int id) async {
    final uri = Uri.parse('$baseUrl/admin/employers/$id/approve');
    final headers = await getHeaders();
    final response = await http.post(uri, headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to approve employer');
    }
  }

  Future<void> rejectEmployer(int id) async {
    final uri = Uri.parse('$baseUrl/admin/employers/$id/reject');
    final headers = await getHeaders();
    final response = await http.post(uri, headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to reject employer');
    }
  }

  Future<dynamic> getJobStats() async {
    final uri = Uri.parse('$baseUrl/admin/job-stats');
    final headers = await getHeaders();
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load job stats');
  }

  Future<List<dynamic>> getAllJobListings() async {
    final uri = Uri.parse('$baseUrl/admin/job-listings');
    final headers = await getHeaders();
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load job listings');
  }

  Future<void> deleteJobListing(int id) async {
    final uri = Uri.parse('$baseUrl/admin/job-listings/$id');
    final headers = await getHeaders();
    final response = await http.delete(uri, headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete job listing');
    }
  }
}
