import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../exceptions/api_exception.dart';

class JobService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<int> getEmployerId() async {
    //final token = await getToken();
    final token = "57|liaTZkuoTzhogo5aKAIAq8A1eTT59ab5JwTLBop67d4119e2";
    if (token == null) {
      throw ApiException.authTokenNotFound();
    }

    final response = await http.get(
      Uri.parse('$baseUrl/employer'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: 10));  // <=== Timeout added

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['id'];
    } else {
      throw ApiException.defaultError('Failed to fetch employer ID.');
    }
  }

  Future<List<dynamic>> getJobsByEmployer(int employerId, {int page = 1, int limit = 8}) async {
    //final token = await getToken();
    final token = "57|liaTZkuoTzhogo5aKAIAq8A1eTT59ab5JwTLBop67d4119e2";
    if (token == null) {
      throw ApiException.authTokenNotFound();
    }

    final response = await http.get(
      Uri.parse('$baseUrl/employer/$employerId/jobs?page=$page&limit=$limit'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw ApiException.defaultError('Failed to load jobs.');
    }
  }

  Future<Map<String, dynamic>> getJobById(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/jobs/$id'),
    ).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      throw ApiException.jobNotFound();
    } else {
      throw ApiException.defaultError('Failed to fetch job details.');
    }
  }

  Future<Map<String, dynamic>> createJob(Map<String, dynamic> data) async {
    //final token = await getToken();
    final token = "57|liaTZkuoTzhogo5aKAIAq8A1eTT59ab5JwTLBop67d4119e2";
    if (token == null) throw ApiException.authTokenNotFound();

    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/jobs'));
    request.headers['Accept'] = 'application/json';
    request.headers['Authorization'] = 'Bearer $token';

    data.forEach((key, value) {
      if (value != null && value is! File) {
        if (key == 'isOpened') {
          request.fields[key] = (value == true || value == "true") ? '1' : '0';
        } else {
          request.fields[key] = value.toString();
        }
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

    var streamedResponse = await request.send().timeout(const Duration(seconds: 10));
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      final error = jsonDecode(response.body);
      throw ApiException.defaultError(error['message']);
    }
  }

  Future<Map<String, dynamic>> updateJob(int id, Map<String, dynamic> data) async {
    //final token = await getToken();
    final token = "57|liaTZkuoTzhogo5aKAIAq8A1eTT59ab5JwTLBop67d4119e2";
    if (token == null) throw ApiException.authTokenNotFound();

    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/jobs/$id?_method=PUT'));
    request.headers['Accept'] = 'application/json';
    request.headers['Authorization'] = 'Bearer $token';

    data.forEach((key, value) {
      if (value != null) {
        if (value is http.MultipartFile) {
          request.files.add(value);
        } else if (key != 'documents' && key != 'company_logo') {
          if (key == 'isOpened') {
            request.fields[key] = (value == true || value == "true") ? '1' : '0';
          } else {
            request.fields[key] = value.toString();
          }
        }
      }
    });

    var streamedResponse = await request.send().timeout(const Duration(seconds: 10));
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final error = jsonDecode(response.body);
      throw ApiException.defaultError(error['message']);
    }
  }

  Future<void> deleteJob(int id) async {
    //final token = await getToken();
    final token = "57|liaTZkuoTzhogo5aKAIAq8A1eTT59ab5JwTLBop67d4119e2";
    if (token == null) throw ApiException.authTokenNotFound();

    final response = await http.delete(
      Uri.parse('$baseUrl/jobs/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw ApiException.jobDeletionFailed();
    }
  }

  Future<Map<String, dynamic>> getFormOptions() async {
    final response = await http.get(
      Uri.parse('$baseUrl/job-options'),
    ).timeout(const Duration(seconds: 10));  // <=== Timeout added

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw ApiException.defaultError('Failed to load job options.');
    }
  }
}
