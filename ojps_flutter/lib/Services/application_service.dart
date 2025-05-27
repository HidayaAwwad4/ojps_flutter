import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/application_model.dart';

class ApplicationService {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<List<Application>> getApplicantsByJobId(int jobId) async {
    final url = Uri.parse('$baseUrl/applications/job/$jobId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Application.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Failed to load applicants');
    }
  }

  Future<Application> getApplicantById(int applicantId) async {
    final url = Uri.parse('$baseUrl/applications/detail/$applicantId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Application.fromJson(data);
    } else {
      throw Exception('Failed to load applicant');
    }
  }

  Future<Application> updateApplicantStatus(int id, String newStatus) async {
    final url = Uri.parse('$baseUrl/applications/$id');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'status': newStatus}),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic>? jsonResponse = response.body.isNotEmpty
          ? jsonDecode(response.body)
          : null;

      if (jsonResponse == null) {
        throw Exception('Empty response body');
      }

      return Application.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to update application status');
    }
  }




}
