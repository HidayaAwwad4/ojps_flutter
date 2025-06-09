import 'package:flutter/material.dart';
import 'package:ojps_flutter/screens/view_resume.dart';
import '../Services/user_service.dart';
import '../constants/spaces.dart';
import '/constants/colors.dart';
import '/constants/dimensions.dart';
import '/widgets/view&edit_profile/profile_image_widget.dart';
import '/widgets/view_profile_employer/profile_info_tile.dart';

class ViewProfile extends StatefulWidget {
  final String token;

  const ViewProfile({super.key, required this.token});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
Map<String, dynamic>? _profileData;
bool _isLoading = true;
String? _error;

@override
void initState() {
  super.initState();
  _fetchProfile();
}

Future<void> _fetchProfile() async {
  try {
    final data = await UserService.getProfile(widget.token);
    setState(() {
      _profileData = data;
      _isLoading = false;
    });
  } catch (e) {
    setState(() {
      _error = 'Failed to load profile';
      _isLoading = false;
    });
  }
}

void _navigateToResumePage() {
  Navigator.pushNamed(context, '/manage_resume');
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
        padding: EdgeInsets.all(AppDimensions.defaultPadding),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
            ? Center(child: Text(_error!))
            : Column(
          children: [
            Center(
              child: ProfileImageWidget(
                imagePath: 'assets/sample_profile.png',
                isEditable: false,
              ),
            ),
            Spaces.vertical(AppDimensions.defaultPadding),


            ProfileInfoTile(
              icon: Icons.person,
              label: 'Full Name',
              value: _profileData?['name'] ?? '',
            ),
            ProfileInfoTile(
              icon: Icons.email,
              label: 'Email',
              value: _profileData?['email'] ?? '',
            ),
            ProfileInfoTile(
              icon: Icons.phone,
              label: 'Phone',
              value: _profileData?['phone'] ?? '',
            ),
            ProfileInfoTile(
              icon: Icons.location_on,
              label: 'Location',
              value: _profileData?['location'] ?? '',
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ViewResumeScreen(token: widget.token)),
                );
              },
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
