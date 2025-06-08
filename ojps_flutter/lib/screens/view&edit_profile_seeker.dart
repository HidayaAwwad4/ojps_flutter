import 'package:flutter/material.dart';
import 'package:ojps_flutter/models/user_data.dart';
import '../constants/spaces.dart';
import '../constants/text_styles.dart';
import '../widgets/custom_bottom_nav.dart';
import '/widgets/view&edit_profile/profile_image_widget.dart';
import '/widgets/view&edit_profile/profile_field_widget.dart';
import '/constants/colors.dart';
import '/constants/dimensions.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ViewEditSeekerProfile extends StatefulWidget {
  const ViewEditSeekerProfile({super.key});

  @override
  State<ViewEditSeekerProfile> createState() => _ViewEditSeekerProfileState();
}

class _ViewEditSeekerProfileState extends State<ViewEditSeekerProfile> {
  final TextEditingController nameController = TextEditingController(
    text: "Haneen",
  );
  final TextEditingController emailController = TextEditingController(
    text: "Haneen@outlook.com",
  );
  final TextEditingController phoneController = TextEditingController(
    text: "+970592222222",
  );
  final TextEditingController bioController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int _currentIndex = AppValues.profileInitialIndex;

  void _onTap(int index) {
    if (index == _currentIndex) return;
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/saved_jobs');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/notifications');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/job_status');
    } else if (index == 4) {

    }
    setState(() {
      _currentIndex = index;
    });
  }

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

  void _handleLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: const Text("Logout"),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }


  void _navigateToResumePage() {
    Navigator.pushNamed(context, '/manage_resume');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _handleLogout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.defaultPadding),

        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileImageWidget(imagePath: UserData().profileImage, isEditable: true,),
              Spaces.vertical(10),
              Text(
                nameController.text.isEmpty ? "Your Name" : nameController.text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Spaces.vertical(4),
              Text(
                emailController.text.isEmpty
                    ? "your.email@example.com"
                    : emailController.text,
                style: const TextStyle(color: Colorss.secondaryTextColor),
              ),

              Spaces.vertical(20),
              ProfileFieldWidget(
                label: "Full Name",
                controller: nameController,
                keyboardType: TextInputType.text,
                enabled: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty){
                    return 'Name is required';
                  } else if (value.trim().length < 4){
                    return 'Name must be at least 4 characters';
                  }
                  return null;

                } ,
              ),

              ProfileFieldWidget(
                label: "Email",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),

              ProfileFieldWidget(
                label: "Phone",
                controller: phoneController,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty){
                    return 'Phone number is required';
                  } else if (!RegExp(r'^05\d{8}$').hasMatch(value.trim())) {
                    return 'Phone must start with 05 and be 10 digits long';
                  }
                  return null;

                },
              ),

              ProfileFieldWidget(
                label: "Bio",
                controller: bioController,
                keyboardType: TextInputType.multiline,
              ),

              TextButton(
                onPressed: _navigateToResumePage,
                child: const Text(
                  "Manage Resume",
                  style: TextStyle(color: Colorss.primaryColor),
                ),
              ),
              Spaces.vertical(20),
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

                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Changes saved successfully'),
                        backgroundColor: Colorss.successValidation,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please complete all required fields correctly',
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colorss.primaryColor,
                ),
                child: const Text(
                  "Save Changes",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
