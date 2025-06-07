import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants//colors.dart';
import 'package:ojps_flutter/constants//text_styles.dart';
import '../widgets/notification_item.dart';
import '../constants/dimensions.dart';


class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<Map<String, dynamic>> newNotifications = [
    {
      'title': 'Asal Company',
      'subtitle': 'Your application was accepted.',
      'image': 'assets/images/company1.png',
    },
    {
      'title': 'ADHAM',
      'subtitle': 'Your application was rejected.',
      'image': 'assets/images/company2.png',
    },
  ];

  List<Map<String, dynamic>> todayNotifications = [];

  List<Map<String, dynamic>> thisWeekNotifications = [
    {
      'title': 'TECHNO',
      'subtitle': 'Job saved by seeker.',
      'image': 'assets/images/company3.png',
    },
  ];

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
            title: item['title'],
            subtitle: item['subtitle'],
            imageUrl: item['image'],
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
