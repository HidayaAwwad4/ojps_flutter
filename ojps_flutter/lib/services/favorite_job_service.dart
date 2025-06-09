import 'dart:convert';
import 'package:http/http.dart' as http;

class FavoriteJobService {
  static Future<List<Map<String, dynamic>>> getSavedJobs(int jobSeekerId) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/favorite_jobs/$jobSeekerId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load saved jobs');
    }
  }

  static Future<bool> removeJobFromFavorites({
    required int jobSeekerId,
    required int jobId,
  }) async {
    final url = Uri.parse('http://your_api_url/api/favorite_jobs/remove');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'jobSeekerId': jobSeekerId,
        'jobId': jobId,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
