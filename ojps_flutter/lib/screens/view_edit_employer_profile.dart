import 'package:flutter/material.dart';
import '../constants/spaces.dart';
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



            const SizedBox(height: 20),
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
