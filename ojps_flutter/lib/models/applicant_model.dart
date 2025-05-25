class Applicant {
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

  Applicant({
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

  factory Applicant.fromJson(Map<String, dynamic> json) {
    final user = json['job_seeker']['user'];
    final jobSeeker = json['job_seeker'];

    return Applicant(
      id: json['id'],
      name: user['name'] ?? '',
      email: user['email'] ?? '',
      appliedAt: json['appliedAt'] != null ? DateTime.tryParse(json['appliedAt']) : null,
      status: json['status'] ?? 'pending',
      imageUrl: user['profile_picture'],
      resumePath: jobSeeker['resume_path'],
      coverLetter: json['cover_letter'],
      location: user['location'],
      summary: user['summary'],
    );
  }
}
