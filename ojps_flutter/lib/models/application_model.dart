class Application {
  final int id; // application id
  final String name;
  final String email;
  final DateTime? appliedAt;
  String status; // "pending", "shortlisted", "accepted", "rejected"
  String? imageUrl; // from user.profile_picture
  String? resumePath; // from job_seeker.resume_path
  String? coverLetter;
  String? location; // from user.location
  String? summary; // from user.summary

  Application({
    required this.id,
    required this.name,
    required this.email,
    this.appliedAt,
    required this.status,
    this.imageUrl,
    this.resumePath,
    this.coverLetter,
    this.location,
    this.summary,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    final jobSeeker = json['job_seeker'];
    final user = jobSeeker != null ? jobSeeker['user'] : null;

    return Application(
      id: json['id'],
      name: user?['name'] ?? '',
      email: user?['email'] ?? '',
      appliedAt: json['applied_at'] != null ? DateTime.tryParse(json['applied_at']) : null,
      status: json['status'] ?? 'pending',
      imageUrl: user?['profile_picture'],
      resumePath: jobSeeker?['resume_path'],
      coverLetter: json['cover_letter'],
      location: user?['location'],
      summary: user?['summary'],
    );

  }

  factory Application.fromMinimalJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'],
      name: '',
      email: '',
      appliedAt: null,
      status: json['status'] ?? 'pending',
      imageUrl: null,
      resumePath: null,
      coverLetter: json['cover_letter'],
      location: null,
      summary: null,
    );
  }

}
