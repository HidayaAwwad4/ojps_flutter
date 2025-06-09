import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import '../models/notificationModel.dart';

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
    InitializationSettings(android: androidSettings);

    await _notifications.initialize(initSettings);
  }

  static Future<List<dynamic>> fetchNotifications(String token) async {
    final response = await http.get(
      Uri.parse('https://127.0.0.1:8000/api/notifications'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => NotificationModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  static Future<int> getNewNotificationCount(String token) async {
    final response = await http.get(
      Uri.parse('https://127.0.0.1:8000/api/notifications/unread/count'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['count'] as int;
    } else {
      throw Exception('Failed to load unread notification count');
    }
  }

  static Future<void> markNotificationAsRead(String token, int id) async {
    final response = await http.post(
      Uri.parse('https://yourdomain.com/api/notifications/mark-as-read/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to mark as read');
    }
  }

  static Future<void> notifySeekerStatus(String token, int seekerId, String status) async {
    final response = await http.post(
      Uri.parse('https://yourdomain.com/api/notifications/seeker/$seekerId/$status'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to notify seeker');
    }
  }

  static Future<void> notifyEmployerActivity(String token, int employerId, String type) async {
    final response = await http.post(
      Uri.parse('https://yourdomain.com/api/notifications/employer/$employerId/$type'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to notify employer');
    }
  }

  static Future<void> showSystemNotification(Map<String, dynamic> notification) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'ojps_channel',
      'OJPS Notifications',
      channelDescription: 'Job and Application Updates',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails generalNotificationDetails =
    NotificationDetails(android: androidDetails);

    await _notifications.show(
      notification['id'] ?? 0,
      'New Notification',
      notification['message'] ?? 'You have a new notification',
      generalNotificationDetails,
    );
  }
}
