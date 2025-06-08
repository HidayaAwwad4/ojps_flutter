import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants//colors.dart';
import 'package:ojps_flutter/constants//text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/notification_service.dart';
import '../widgets/notification_item.dart';
import '../constants/dimensions.dart';


class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {


  List<Map<String, dynamic>> newNotifications = [];
  List<Map<String, dynamic>> todayNotifications = [];
  List<Map<String, dynamic>> thisWeekNotifications = [];

  void sendSystemNotification(String title, String body) {
    NotificationService.showSystemNotification({
      'id': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'message': body,
    });
  }

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token != null) {
        final notifications = await NotificationService.fetchNotifications(token);

        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);

        final List<Map<String, dynamic>> newNotifs = [];
        final List<Map<String, dynamic>> todayNotifs = [];
        final List<Map<String, dynamic>> weekNotifs = [];

        for (var notif in notifications) {
          final createdAt = DateTime.tryParse(notif['created_at'] ?? '');

          if (createdAt == null) continue;

          final diff = now.difference(createdAt);

          if (!notif['is_read']) {
            newNotifs.add(notif);
            await NotificationService.showSystemNotification({
              'id': notif['id'],
              'message': notif['message'],
            });
          } else if (createdAt.isAfter(today)) {
            todayNotifs.add(notif);
          } else if (diff.inDays <= 7) {
            weekNotifs.add(notif);
          }
        }

        setState(() {
          newNotifications = newNotifs;
          todayNotifications = todayNotifs;
          thisWeekNotifications = weekNotifs;
        });
      } else {
        print('No token found');
      }
    } catch (e) {
      print('Error loading notifications: $e');
    }
  }

  void moveToToday(int index) {
    setState(() {
      todayNotifications.add(newNotifications[index]);
      newNotifications.removeAt(index);

      if (todayNotifications.length > 3) {
        thisWeekNotifications.add(todayNotifications.removeAt(0));
      }
    });
  }

  Widget buildSection(String title, List<Map<String, dynamic>> list, bool isNew) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.width15, vertical: AppDimensions.height10),
          child: Text(title, style: AppValues.textStyleHeader),
        ),
        ...List.generate(list.length, (index) {
          final item = list[index];
          return NotificationItem(
            title: item['message'] ?? 'No Title',
            subtitle: item['type'] ?? '',
            imageUrl: item['avatar'] ?? 'assets/images/default.png',
            isNew: isNew,
            onTap: isNew ? () => moveToToday(index) : () {},
          );
        }),
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications", style: AppValues.textStyleAppBar ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSection("New", newNotifications, true),
            buildSection("Today", todayNotifications, false),
            buildSection("This Week", thisWeekNotifications, false),
          ],
        ),
      ),
    );
  }
}
