class Applicant {
  final String id;
  final String name;
  final String email;
  final DateTime appliedAt;
  String status; // "pending", "accepted", "rejected"
  String? imageUrl;
  String? resumeFilePath;
  String? coverLetter;

  Applicant({
    required this.id,
    required this.name,
    required this.email,
    required this.appliedAt,
    this.status = "pending",
    this.imageUrl,
    this.resumeFilePath,
    this.coverLetter,
  });
}

final List<Applicant> applicants = [
  Applicant(
    id: '1',
    name: 'Layla Ahmad',
    email: 'layla.ahmad@example.com',
    appliedAt: DateTime(2025, 5, 9),
    status: 'pending',
    imageUrl: 'assets/sara.jpg',
    resumeFilePath: 'assets/resume_sara.pdf',
    coverLetter: 'Dear team, I am excited to apply for the position...',
  ),
  Applicant(
    id: '2',
    name: 'Omar Khaled',
    email: 'omar.khaled@example.com',
    appliedAt: DateTime(2025, 5, 8),
    status: 'rejected',
    resumeFilePath: 'assets/resume_omar.jpg',
    coverLetter: 'I believe my skills are a great fit for your company...',
  ),
  Applicant(
    id: '3',
    name: 'Sara Youssef',
    email: 'sara.youssef@example.com',
    appliedAt: DateTime(2025, 5, 7),
    status: 'accepted',
    imageUrl: 'assets/sara.jpg',
    resumeFilePath: 'assets/resume_sara.pdf',
    coverLetter: 'With 10 years in management, I can lead your projects...',
  ),
];
