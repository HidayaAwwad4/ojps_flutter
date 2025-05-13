class Job {
  String title;
  String description;
  String salary;
  String employment;
  String imageUrl;
  bool isOpen;
  String companyLocation;
  String experience;
  String language;
  String schedule;
  String category;

  Job({
    required this.title,
    required this.description,
    required this.salary,
    required this.employment,
    required this.imageUrl,
    required this.isOpen,
    required this.companyLocation,
    required this.experience,
    required this.language,
    required this.schedule,
    required this.category,
  });
}
List<Job> jobs = [
  Job(
    title: 'Full-Stack Developer',
    description:
    'Responsible for developing both front-end and back-end systems, ensuring seamless performance and efficiency.',
    salary: '\$800 - \$1000 Salary/Month',
    employment: 'Remote',
    imageUrl: 'assets/adham.jpg',
    isOpen: true,
    companyLocation: 'Amman, Jordan',
    experience: '1-3 years',
    language: 'English, Arabic',
    schedule: 'Flexible',
    category: 'Technology',
  ),
  Job(
    title: 'Mobile App Developer',
    description:
    'Design and develop mobile apps for Android and iOS platforms.',
    salary: '\$700 - \$900 Salary/Month',
    employment: 'Remote',
    imageUrl: 'assets/adham.jpg',
    isOpen: false,
    companyLocation: 'Remote',
    experience: 'Not required',
    language: 'English',
    schedule: 'Morning shift',
    category: 'Technology',
  ),
  Job(
    title: 'Backend Developer',
    description:
    'Work on server-side applications and APIs for smooth operations.',
    salary: '\$900 - \$1200 Salary/Month',
    employment: 'Remote',
    imageUrl: 'assets/adham.jpg',
    isOpen: true,
    companyLocation: 'Dubai, UAE',
    experience: '3+ years',
    language: 'English',
    schedule: 'Evening shift',
    category: 'Technology',
  ),
  Job(
    title: 'UI/UX Designer',
    description:
    'Create user-friendly and visually appealing designs for apps and websites.',
    salary: '\$600 - \$850 Salary/Month',
    employment: 'Contract',
    imageUrl: 'assets/adham.jpg',
    isOpen: false,
    companyLocation: 'Cairo, Egypt',
    experience: 'Not required',
    language: 'Arabic',
    schedule: 'Remote, Flexible',
    category: 'Technology',
  ),
];
