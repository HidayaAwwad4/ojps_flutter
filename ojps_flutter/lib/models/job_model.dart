class Job {
  String title;
  String description;
  String salary;
  String location;
  String category;
  String languages;
  String schedule;
  String experience;
  String employment;
  String? companyLogo;
  String? documents;
  bool isOpened;
  int employerId;

  Job({
    required this.title,
    required this.description,
    required this.salary,
    required this.location,
    required this.category,
    required this.languages,
    required this.schedule,
    required this.experience,
    required this.employment,
    this.companyLogo,
    this.documents,
    required this.isOpened,
    required this.employerId,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      salary: json['salary'] ?? '' ,
      location: json['location'] ?? '',
      category: json['category'] ?? '',
      languages: json['languages'] ?? '',
      schedule: json['schedule'] ?? '',
      experience: json['experience'] ?? '',
      employment: json['employment'] ?? '',
      companyLogo: json['company_logo'],
      documents: json['documents'],
      isOpened: json['isOpened'] == 1 || json['isOpened'] == true,
      employerId: json['employer_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'salary': salary,
      'location': location,
      'category': category,
      'languages': languages,
      'schedule': schedule,
      'experience': experience,
      'employment': employment,
      'company_logo': companyLogo,
      'documents': documents,
      'isOpened': isOpened,
      'employer_id': employerId,
    };
  }
}
