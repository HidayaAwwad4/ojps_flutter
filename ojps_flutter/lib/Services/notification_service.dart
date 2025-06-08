import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings
    );

    await _notifications.initialize(initSettings);
  }

  static Future<List<dynamic>> fetchNotifications(String token) async {
    final response = await http.get(
      Uri.parse('https://127.0.0.1:8000/api/get-user-notifications'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load notifications');
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
