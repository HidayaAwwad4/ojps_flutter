import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants//text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/notification_service.dart';
import '../models/notificationModel.dart';
import '../widgets/notification_item.dart';
import '../constants/dimensions.dart';


class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {


  List<NotificationModel> newNotifications = [];
  List<NotificationModel> todayNotifications = [];
  List<NotificationModel> thisWeekNotifications = [];

  late String token;


  void sendSystemNotification(String title, String body) {
    NotificationService.showSystemNotification({
      'id': DateTime
          .now()
          .millisecondsSinceEpoch ~/ 1000,
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
      final storedToken = prefs.getString('auth_token');

      if (storedToken == null) {
        print('No token found in SharedPreferences');
        return;
      }

      token = storedToken;

      final fetched = await NotificationService.fetchNotifications(token);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      List<NotificationModel> newNotifs = [];
      List<NotificationModel> todayNotifs = [];
      List<NotificationModel> weekNotifs = [];

      for (var notif in fetched) {
        final createdAt = notif.createdAt;
        if (createdAt == null) continue;

        final diff = now.difference(createdAt);
        if (!notif.isRead) {
          newNotifs.add(notif);
          await NotificationService.showSystemNotification({
            'id': notif.id,
            'message': notif.message,
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

  void handleTap(NotificationModel item, {bool isNew = false, int? index}) {
    if (isNew && index != null) moveToToday(index);
    if (item.redirectUrl.isNotEmpty) {
      Navigator.pushNamed(context, item.redirectUrl);
    }
  }


  Widget buildSection(String title, List<NotificationModel> list, bool isNew) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.width15,
              vertical: AppDimensions.height10),
          child: Text(title, style: AppValues.textStyleHeader),
        ),
        ...List.generate(list.length, (index) {
          final item = list[index];
          return NotificationItem(
            title: item.message,
            subtitle: item.type,
            imageUrl: 'assets/images/default.png',
            isNew: isNew,
            onTap: () => handleTap(item, isNew: isNew, index: index),
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications", style: AppValues.textStyleAppBar),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {

            }
          },
        ),
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

