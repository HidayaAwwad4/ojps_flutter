import 'package:flutter/material.dart';
import '/widgets/view&edit_profile/profile_image_widget.dart';
import '/widgets/view&edit_profile/profile_field_widget.dart';
import '/constants/colors.dart';
import '/constants/dimensions.dart';

class ViewEditSeekerProfileScreen extends StatefulWidget {
  const ViewEditSeekerProfileScreen({super.key});

  @override
  State<ViewEditSeekerProfileScreen> createState() => _ViewEditSeekerProfileScreenState();
}

class _ViewEditSeekerProfileScreenState extends State<ViewEditSeekerProfileScreen> {
  final TextEditingController nameController = TextEditingController(text: "Wafa Al-Adham");
  final TextEditingController emailController = TextEditingController(text: "Al-Adham2020@example.com");
  final TextEditingController phoneController = TextEditingController(text: "+970592222222");
  final TextEditingController bioController = TextEditingController();

  void _navigateToResumePage() {
    Navigator.pushNamed(context, '/resume');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ProfileImageWidget(),
            const SizedBox(height: 10),
            const Text("Lorem ipsum", style: TextStyle(fontWeight: FontWeight.bold)),
            const Text("Lorem.ipsum112@example.com", style: TextStyle(color: secondaryTextColor)),
            const SizedBox(height: 20),
            ProfileFieldWidget(label: "Full Name", controller: nameController),
            ProfileFieldWidget(label: "Email", controller: emailController),
            ProfileFieldWidget(label: "Phone", controller: phoneController),
            ProfileFieldWidget(label: "Bio", controller: bioController),
            TextButton(
              onPressed: _navigateToResumePage,
              child: const Text("Manage Resume", style: TextStyle(color: primaryColor)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              child: const Text("Save Changes"),
            )
          ],
        ),
      ),
     /* bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
        selectedItemColor: primaryColor,
        unselectedItemColor: secondaryTextColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: "Jobs"),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: "Post"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notification"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ), */
    );
  }
}
