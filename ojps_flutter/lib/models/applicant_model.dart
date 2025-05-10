class Applicant {
  final String id;
  final String name;
  final String email;
  final DateTime appliedAt;
  String status; // "pending", "accepted", "rejected"
  String? imageUrl; // Optional field for the applicant's image
  String? resume; // Optional field for the applicant's resume

  Applicant({
    required this.id,
    required this.name,
    required this.email,
    required this.appliedAt,
    this.status = "pending",
    this.imageUrl, // Initialize the imageUrl
    this.resume, // Initialize the resume
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
    resume: 'I am a software developer with 5 years of experience...',
  ),
  Applicant(
    id: '2',
    name: 'Omar Khaled',
    email: 'omar.khaled@example.com',
    appliedAt: DateTime(2025, 5, 8),
    status: 'pending',
    resume: 'Looking forward to contributing to your team...',
  ),
  Applicant(
    id: '3',
    name: 'Sara Youssef',
    email: 'sara.youssef@example.com',
    appliedAt: DateTime(2025, 5, 7),
    status: 'accepted',
    imageUrl: 'assets/sara.jpg',
    resume: 'Extensive experience in project management...',
  ),
];
