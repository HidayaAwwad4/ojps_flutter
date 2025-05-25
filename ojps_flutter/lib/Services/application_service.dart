import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/applicant_model.dart';

class ApplicationService {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<List<Applicant>> getApplicantsByJobId(int jobId) async {
    final url = Uri.parse('$baseUrl/applications/job/$jobId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Applicant.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Failed to load applicants');
    }
  }

  Future<Applicant> getApplicantById(int applicantId) async {
    final url = Uri.parse('$baseUrl/applications/detail/$applicantId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Applicant.fromJson(data);
    } else {
      throw Exception('Failed to load applicant');
    }
  }


  Future<Applicant> updateApplicantStatus(String id, String status) async {
    final response = await http.put(
      Uri.parse('$baseUrl/applicants/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'status': status}),
    );
    if (response.statusCode == 200) {
      return Applicant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update status');
    }
  }


}
