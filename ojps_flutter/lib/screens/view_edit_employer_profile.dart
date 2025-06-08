import 'package:flutter/material.dart';
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
    final TextEditingController nameController = TextEditingController(text: "Wafa Al-Adham");
  final TextEditingController emailController = TextEditingController(text: "Al-Adham2020@example.com");
  final TextEditingController phoneController = TextEditingController(text: "+970599999999");
  final TextEditingController companyController = TextEditingController(text: "Al-adham");
  final TextEditingController locationController = TextEditingController(text: "palestine-Nablus");
  final TextEditingController bioController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
          onPressed: (){
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
                label: "Phone",
                controller: phoneController,
              keyboardType: TextInputType.phone,
            ),


            ProfileFieldWidget(
                label: "Company"
                , controller: companyController
            ),


            ProfileFieldWidget(
                label: "Location",
                controller: locationController
            ),


            ProfileFieldWidget(
                label: "Bio",
                controller: bioController,
              keyboardType: TextInputType.multiline,
            ),



            Spaces.vertical(20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()){
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Changes saved successfully'),
                        backgroundColor: Colorss.successValidation,
                      )
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please complete all required fields correctly'),
                      )
                  );
                }
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
      ),
    );
  }
}
