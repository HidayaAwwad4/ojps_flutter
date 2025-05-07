import '../AppUser.dart';

class SeekerProfile extends AppUser {
  String? imagePath; // Optional field for storing profile image path

  SeekerProfile({
    required String fullName,
    required String email,
    required String phone,
    required String bio,
    this.imagePath, // Accept the optional imagePath
  }) : super(
    fullName: fullName,
    email: email,
    phone: phone,
    bio: bio,
  );
}
