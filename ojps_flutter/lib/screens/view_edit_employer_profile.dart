import 'package:flutter/material.dart';
import '/widgets/view&edit_profile/profile_image_widget.dart';
import '/widgets/view&edit_profile/profile_field_widget.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';

class ViewEditEmployerProfile extends StatefulWidget {
  const ViewEditEmployerProfile({super.key});

  @override
  State<ViewEditEmployerProfile> createState() => _ViewEditEmployerProfileState();
}

class _ViewEditEmployerProfileState extends State<ViewEditEmployerProfile> {
  final TextEditingController nameController = TextEditingController(text: "Rami Fayed");
  final TextEditingController emailController = TextEditingController(text: "Fayed.rami@example.com");
  final TextEditingController phoneController = TextEditingController(text: "+970599999999");
  final TextEditingController companyController = TextEditingController(text: "Rami Tech");
  final TextEditingController locationController = TextEditingController(text: "Ramallah");
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
    companyController.dispose();
    locationController.dispose();
    bioController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(dimentions.defaultPadding),
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
            ProfileFieldWidget(label: "Company", controller: companyController),
            ProfileFieldWidget(label: "Location", controller: locationController),
            ProfileFieldWidget(label: "Bio", controller: bioController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
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
