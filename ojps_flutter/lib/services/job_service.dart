import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart';
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
    request.headers['Accept'] = 'application/json';
    data.forEach((key, value) {
      if (value != null && value is! File) {
        request.fields[key] = value.toString();
      }
    });

    if (data['company_logo'] != null && data['company_logo'] is File) {
      File logoFile = data['company_logo'];
      request.files.add(
        await http.MultipartFile.fromPath(
          'company_logo',
          logoFile.path,
          filename: basename(logoFile.path),
        ),
      );
    }

    if (data['documents'] != null && data['documents'] is File) {
      File docFile = data['documents'];
      request.files.add(
        await http.MultipartFile.fromPath(
          'documents',
          docFile.path,
          filename: basename(docFile.path),
        ),
      );
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create job: ${response.body}');
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
