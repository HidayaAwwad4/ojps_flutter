import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/spaces.dart';
import '../constants/text_styles.dart';
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
    final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchProfileData();


    nameController.addListener(() => setState(() {}));
    emailController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    companyController.dispose();
    locationController.dispose();
    super.dispose();
  }

    Future<void> fetchProfileData() async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token'); // stored when logging in

      final url = Uri.parse('http://YOUR_BACKEND_URL/api/employer/profile');

      try {
        final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body)['user'];

          setState(() {
            nameController.text = data['name'] ?? '';
            emailController.text = data['email'] ?? '';
            companyController.text = data['company'] ?? '';
            locationController.text = data['location'] ?? '';
          });
        } else {
          print('Failed to fetch profile: ${response.body}');
        }
      } catch (e) {
        print('Error fetching profile: $e');
      }
    }


    Future<void> _saveProfileChanges() async {
      final url = Uri.parse('https://your-api.com/api/employer/profile'); // Replace with your actual API URL
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token'); // Replace with your token key

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': nameController.text,
          'email': emailController.text,
          'company': companyController.text,
          'location': locationController.text,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update profile: ${response.reasonPhrase}'),
            backgroundColor: Colors.red,
          ),
        );
      }
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {

            }
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
       child : Form(
          key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileImageWidget(),
             Spaces.vertical(10),
            Text(
              nameController.text.isEmpty ? "Your Name" : nameController.text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Spaces.vertical(4),
            Text(
              emailController.text.isEmpty ? "your.email@example.com" : emailController.text,
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
                label: "Company"
                , controller: companyController
            ),


            ProfileFieldWidget(
                label: "Location",
                controller: locationController
            ),



            Spaces.vertical(20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _saveProfileChanges();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please complete all required fields correctly'),
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
    );
  }
}
