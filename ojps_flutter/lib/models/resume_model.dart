class ResumeModel {
  final String fullName, email, location, phone, summary, imageUrl;
  final List<Experience> experiences;
  final List<Education> educations;

  ResumeModel({
    required this.fullName,
    required this.email,
    required this.location,
    required this.phone,
    required this.summary,
    required this.experiences,
    required this.educations,
    this.imageUrl =""
  });

}

class Experience {
  final String jobTitle, company, startDate, endDate,bulletPoint;
  Experience({required this.jobTitle, required this.company, required this.startDate, required this.endDate , required this.bulletPoint});
}

class Education {
  final String degree, institution, startDate, endDate, gpa, honors;
  Education({required this.degree, required this.institution, required this.startDate, required this.endDate, required this.gpa , required this.honors});
}
