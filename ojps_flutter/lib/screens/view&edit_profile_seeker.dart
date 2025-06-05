import 'package:flutter/material.dart';
import '/widgets/view&edit_profile/profile_image_widget.dart';
import '/widgets/view&edit_profile/profile_field_widget.dart';
import '/constants/colors.dart';
import '/constants/dimensions.dart';

class ViewEditSeekerProfile extends StatefulWidget {
  const ViewEditSeekerProfile({super.key});

  @override
  State<ViewEditSeekerProfile> createState() => _ViewEditSeekerProfileState();
}

class _ViewEditSeekerProfileState extends State<ViewEditSeekerProfile> {
  final TextEditingController nameController = TextEditingController(text: "Wafa Al-Adham");
  final TextEditingController emailController = TextEditingController(text: "Al-Adham2020@example.com");
  final TextEditingController phoneController = TextEditingController(text: "+970592222222");
  final TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController.addListener(() => setState(() {}));
    emailController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    bioController.dispose();
    super.dispose();
  }
  void _navigateToResumePage() {
    Navigator.pushNamed(context, '/resume');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        leading: BackButton(
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileImageWidget(),
            const SizedBox(height: 10),
            Text(
              nameController.text.isEmpty ? "Your Name" : nameController.text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(
              emailController.text.isEmpty ? "your.email@example.com" : emailController.text,
              style: const TextStyle(color: Colorss.secondaryTextColor),
            ),
            const SizedBox(height: 20),
            ProfileFieldWidget(
              label: "Full Name",
              controller: nameController,
              enabled: true,
            ),
            ProfileFieldWidget(label: "Email", controller: emailController),
            ProfileFieldWidget(label: "Phone", controller: phoneController),
            ProfileFieldWidget(label: "Bio", controller: bioController),
            TextButton(
              onPressed: _navigateToResumePage,
              child: const Text("Manage Resume", style: TextStyle(color: Colorss.primaryColor)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final email = emailController.text;
                final phone = phoneController.text;
                final bio = bioController.text;


                print("Saved Profile:");
                print("Name: $name");
                print("Email: $email");
                print("Phone: $phone");
                print("Bio: $bio");

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Profile changes saved.")),
                );
              },

              style: ElevatedButton.styleFrom(
                  backgroundColor: Colorss.primaryColor
              ),
              child: const Text(
                "Save Changes",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

