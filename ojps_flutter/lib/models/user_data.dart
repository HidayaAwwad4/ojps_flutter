import 'dart:io';

class UserData {
  static final UserData _instance = UserData._internal();

  factory UserData() => _instance;

  UserData._internal();

  File? imageFile;
  String? imageUrl;
  String? name;
  String? email;
  String? phone;
  String? bio;

  Object? get profileImage => imageFile ?? imageUrl;
}
