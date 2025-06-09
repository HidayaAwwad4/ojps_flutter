class Job {
  int id;
  String title;
  String description;
  double salary;
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
    required this.id,
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
      id: int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      salary: double.tryParse(json['salary'].toString()) ?? 0.0,
      location: json['location'] ?? '',
      category: json['category'] ?? '',
      languages: json['languages'] ?? '',
      schedule: json['schedule'] ?? '',
      experience: json['experience'] ?? '',
      employment: json['employment'] ?? '',
      companyLogo: json['company_logo'],
      documents: json['documents'],
      isOpened: (json['isOpened'] == 1 || json['isOpened'] == true || json['isOpened'] == "true"),
      employerId: int.tryParse(json['employer_id'].toString()) ?? 0,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
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

  Job copyWith({
    int? id,
    String? title,
    String? description,
    double? salary,
    String? location,
    String? category,
    String? languages,
    String? schedule,
    String? experience,
    String? employment,
    String? companyLogo,
    String? documents,
    bool? isOpened,
    int? employerId,
  }) {
    return Job(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      salary: salary ?? this.salary,
      location: location ?? this.location,
      category: category ?? this.category,
      languages: languages ?? this.languages,
      schedule: schedule ?? this.schedule,
      experience: experience ?? this.experience,
      employment: employment ?? this.employment,
      companyLogo: companyLogo ?? this.companyLogo,
      documents: documents ?? this.documents,
      isOpened: isOpened ?? this.isOpened,
      employerId: employerId ?? this.employerId,
    );
  }
}
