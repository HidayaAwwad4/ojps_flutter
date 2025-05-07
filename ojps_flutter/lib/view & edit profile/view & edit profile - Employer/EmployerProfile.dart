import '../AppUser.dart';

class Employer extends AppUser {
  String company;
  String location;

  Employer({
   required String fullName,
    required String email,
 required String phone,
 required String bio,
    required this.company,
    required this.location,
  }) : super(
    fullName: fullName,
    email: email,
    phone: phone,
    bio: bio,
  );
}