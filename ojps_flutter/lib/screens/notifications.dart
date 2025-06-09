import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/text_styles.dart';
import 'package:ojps_flutter/constants/dimensions.dart';
import '../models/notificationModel.dart';
import '../widgets/notification_item.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<NotificationModel> newNotifications = [];
  List<NotificationModel> todayNotifications = [];
  List<NotificationModel> thisWeekNotifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications(); // Load mock data
  }

  Future<void> _loadNotifications() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate loading delay

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Fake notifications for testing
    List<NotificationModel> mockNotifications = [
      NotificationModel(
        id: 1,
        message: "Your job application was accepted.",
        type: "Application Accepted",
        isRead: false,
        createdAt: now.subtract(Duration(minutes: 10)),
        redirectUrl: "/job-details/1",
      ),
      NotificationModel(
        id: 2,
        message: "Your application for Flutter Developer was rejected.",
        type: "Application Rejected",
        isRead: false,
        createdAt: now.subtract(Duration(hours: 2)),
        redirectUrl: "/job-details/2",
      ),
      NotificationModel(
        id: 3,
        message: "A job seeker applied to your posted job.",
        type: "New Applicant",
        isRead: true,
        createdAt: now.subtract(Duration(hours: 4)),
        redirectUrl: "/applicants",
      ),
      NotificationModel(
        id: 4,
        message: "Someone saved your job listing.",
        type: "Saved Job",
        isRead: true,
        createdAt: now.subtract(Duration(days: 3)),
        redirectUrl: "/job-details/3",
      ),
      NotificationModel(
        id: 5,
        message: "System update available.",
        type: "System",
        isRead: true,
        createdAt: now.subtract(Duration(days: 6)),
        redirectUrl: "",
      ),
    ];

    // Group notifications
    List<NotificationModel> newNotifs = [];
    List<NotificationModel> todayNotifs = [];
    List<NotificationModel> weekNotifs = [];

    for (var notif in mockNotifications) {
      final createdAt = notif.createdAt!;
      final diff = now.difference(createdAt);
      if (!notif.isRead) {
        newNotifs.add(notif);
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
        if (list.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.width15,
                vertical: AppDimensions.height10),
            child: Text("No notifications", style: AppValues.textStyleHeader),
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