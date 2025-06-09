class User {
  final int? id; 
  final String name;
  final String email;
  final String? profilePicture;
  final String? location;
  final String? summary;
  final int? roleId;
  final bool? isApproved;

  User({
    this.id,
    required this.name,
    required this.email,
    this.profilePicture,
    this.location,
    this.summary,
    this.roleId,
    this.isApproved,
  });


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profilePicture: json['profile_picture'],
      location: json['location'],
      summary: json['summary'],
      roleId: json['role_id'],
      isApproved: json['is_approved'] == 1 || json['is_approved'] == true,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profile_picture': profilePicture,
      'location': location,
      'summary': summary,
      'role_id': roleId,
      'is_approved': isApproved,
    };
  }
}
