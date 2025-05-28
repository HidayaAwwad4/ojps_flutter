import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/dimensions.dart';
import '/widgets/view&edit_profile/profile_image_widget.dart';
import '/widgets/view_profile_employer/profile_info_tile.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: Padding(
        padding: EdgeInsets.all(dimentions.defaultPadding),
        child: Column(
          children: [
            Center(
              child: ProfileImageWidget(
                imagePath: 'assets/sample_profile.png',
                isEditable: false,
              ),
            ),
            SizedBox(height: dimentions.defaultPadding),


            ProfileInfoTile(
              icon: Icons.person,
              label: 'Full Name',
              value: 'Ahmad Khalil',
            ),
            ProfileInfoTile(
              icon: Icons.email,
              label: 'Email',
              value: 'ahmad@example.com',
            ),
            ProfileInfoTile(
              icon: Icons.phone,
              label: 'Phone',
              value: '+970 599 123 456',
            ),
            ProfileInfoTile(
              icon: Icons.location_on,
              label: 'Location',
              value: 'Ramallah, Palestine',
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colorss.primaryColor
              ),
              child: const Text(
                "View Resume",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
