class Job {
  String title;
  String description;
  String salary;
  String employment;
  String imageUrl;
  bool isOpen;

  Job({
    required this.title,
    required this.description,
    required this.salary,
    required this.employment,
    required this.imageUrl,
    required this.isOpen,
  });
}

List<Job> jobs = [
  Job(
    title: 'Full-Stack Developer',
    description:
    'Responsible for developing both front-end and back-end systems, ensuring seamless performance and efficiency',
    salary: '\$800 - \$1000 Salary/Month',
    employment: 'Part time',
    imageUrl: 'lib/assets/adham.jpg',
    isOpen: true,
  ),
  Job(
    title: 'Mobile App Developer',
    description:
    'Design and develop mobile apps for Android and iOS platforms.',
    salary: '\$700 - \$900 Salary/Month',
    employment: 'Full time',
    imageUrl: 'lib/assets/adham.jpg',
    isOpen: false,
  ),
  Job(
    title: 'Backend Developer',
    description:
    'Work on server-side applications and APIs for smooth operations.',
    salary: '\$900 - \$1200 Salary/Month',
    employment: 'Remote',
    imageUrl: 'lib/assets/adham.jpg',
    isOpen: true,
  ),
  Job(
    title: 'UI/UX Designer',
    description:
    'Create user-friendly and visually appealing designs for apps and websites.',
    salary: '\$600 - \$850 Salary/Month',
    employment: 'Contract',
    imageUrl: 'lib/assets/adham.jpg',
    isOpen: false,
  ),
];