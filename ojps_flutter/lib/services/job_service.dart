import 'dart:convert';
import 'package:http/http.dart' as http;

class JobService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  Future<List<dynamic>> getJobsByEmployer(int employerId) async {
    final response = await http.get(Uri.parse('$baseUrl/employer/$employerId/jobs'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  Future<Map<String, dynamic>> getJobById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/jobs/$id'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Job not found');
    }
  }

  Future<Map<String, dynamic>> createJob(Map<String, dynamic> data) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/jobs'));

    data.forEach((key, value) {
      if (value != null && value is! http.MultipartFile) {
        request.fields[key] = value.toString();
      }
    });

    if (data['company_logo'] != null) {
      request.files.add(data['company_logo']);
    }

    if (data['documents'] != null) {
      request.files.add(data['documents']);
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create job');
    }
  }

  Future<Map<String, dynamic>> updateJob(int id, Map<String, dynamic> data) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/jobs/$id?_method=PUT'));

    data.forEach((key, value) {
      if (value != null && value is! http.MultipartFile) {
        request.fields[key] = value.toString();
      }
    });

    if (data['company_logo'] != null) {
      request.files.add(data['company_logo']);
    }

    if (data['documents'] != null) {
      request.files.add(data['documents']);
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update job');
    }
  }

  Future<void> deleteJob(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/jobs/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete job');
    }
  }

  Future<Map<String, dynamic>> getFormOptions() async {
    final response = await http.get(Uri.parse('$baseUrl/job-options'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch form options');
    }
  }
}
