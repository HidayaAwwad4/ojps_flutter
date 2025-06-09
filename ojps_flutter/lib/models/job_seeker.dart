class JobSeeker {
  final int id;
  final String name;
  final String email;
  final String? profilePicture;
  final String? location;
  final String? summary;
  final List<dynamic>? experience;
  final List<dynamic>? education;
  final List<dynamic>? skills;
  final String? resumeUrl;

  JobSeeker({
    required this.id,
    required this.name,
    required this.email,
    this.profilePicture,
    this.location,
    this.summary,
    this.experience,
    this.education,
    this.skills,
    this.resumeUrl,
  });

  factory JobSeeker.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {};
    return JobSeeker(
      id: user['id'],
      name: user['name'] ?? '',
      email: user['email'] ?? '',
      profilePicture: user['profile_picture'],
      location: user['location'],
      summary: user['summary'],
      experience: json['experience'],
      education: json['education'],
      skills: json['skills'],
      resumeUrl: json['resume_path'],
    );
  }
}
