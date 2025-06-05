class ResumeModel {
  final String fullName, email, location, phone, summary, imageUrl;
  final List<Experience> workExperiences;
  final List<Education> educations;

  ResumeModel({
    required this.fullName,
    required this.email,
    required this.location,
    required this.phone,
    required this.summary,
    required this.imageUrl,
    required this.workExperiences,
    required this.educations,
  });
}

class Experience {
  final String position, company, duration, description;
  Experience(this.position, this.company, this.duration, this.description);
}

class Education {
  final String degree, university, duration, details;
  Education(this.degree, this.university, this.duration, this.details);
}
