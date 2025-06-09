import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class JobService {
  final String apiUrl = 'http://127.0.0.1:8000/api';
  static final String token = '10|4GAzzySoq1BTHMgvXGnGIOt5EqWW1w4hFrZ22uy79e79099e';

  Future<Map<String, dynamic>> getJobDetails(int jobId) async {
    try {
      final response = await http
          .get(
        Uri.parse('$apiUrl/jobs/$jobId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw HttpException('Failed to load job details (status: ${response.statusCode})');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on HttpException catch (e) {
      throw Exception(e.message);
    } on FormatException {
      throw Exception('Bad response format');
    } on TimeoutException {
      throw Exception('Request timed out');
    }
  }
  Future<int> getCurrentUserId() async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/user'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['id'];
      } else {
        throw HttpException('Failed to fetch user (status: ${response.statusCode})');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on HttpException catch (e) {
      throw Exception(e.message);
    } on FormatException {
      throw Exception('Bad response format');
    } on TimeoutException {
      throw Exception('Request timed out');
    }
  }

  Future<List<dynamic>> searchJobs(String query) async {
    try {
      final response = await http
          .get(
        Uri.parse('$apiUrl/search-jobs?query=$query'),
        headers: {
          'Accept': 'application/json',
        },
      )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw HttpException('Failed to search jobs (status: ${response.statusCode})');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on HttpException catch (e) {
      throw Exception(e.message);
    } on FormatException {
      throw Exception('Bad response format');
    } on TimeoutException {
      throw Exception('Request timed out');
    }
  }

  Future<List<dynamic>> fetchJobsByCategory(String category) async {
    try {
      final response = await http
          .get(
        Uri.parse('$apiUrl/jobs/category/$category'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw HttpException('Failed to load jobs by category (status: ${response.statusCode})');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on HttpException catch (e) {
      throw Exception(e.message);
    } on FormatException {
      throw Exception('Bad response format');
    } on TimeoutException {
      throw Exception('Request timed out');
    }
  }

  Future<List<dynamic>> fetchRecommendedJobs() async {
    try {
      final response = await http
          .get(
        Uri.parse('$apiUrl/jobs/recommended'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw HttpException('Failed to load recommended jobs (status: ${response.statusCode})');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on HttpException catch (e) {
      throw Exception(e.message);
    } on FormatException {
      throw Exception('Bad response format');
    } on TimeoutException {
      throw Exception('Request timed out');
    }
  }

  Future<List<dynamic>> getApplicationsByJobSeekerId(int jobSeekerId) async {
    try {
      final response = await http
          .get(
        Uri.parse('$apiUrl/applications/by-job-seeker/$jobSeekerId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw HttpException('Failed to load applications (status: ${response.statusCode})');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on HttpException catch (e) {
      throw Exception(e.message);
    } on FormatException {
      throw Exception('Bad response format');
    } on TimeoutException {
      throw Exception('Request timed out');
    }
  }
  Future<void> submitApplication({
    required int jobId,
    required String coverLetter,
    required int jobSeekerId,
    File? cvFile,
  }) async {
    try {
      var uri = Uri.parse('$apiUrl/applications/submit');
      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['job_id'] = jobId.toString()
        ..fields['cover_letter'] = coverLetter
        ..fields['job_seeker_id'] = jobSeekerId.toString();

      if (cvFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('cv_file', cvFile.path),
        );
      }

      final streamedResponse = await request.send().timeout(Duration(seconds: 15));
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200) {
        throw HttpException('Failed to submit application (status: ${response.statusCode})');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on TimeoutException {
      throw Exception('Request timed out');
    } on HttpException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }


}
