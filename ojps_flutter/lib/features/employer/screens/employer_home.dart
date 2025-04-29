import 'package:flutter/material.dart';
import '../models/job_model.dart';
import '../widgets/job_card.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Job> jobs = [
      Job(
          title: 'Full-Stack Developer',
          description: 'Responsible for developing both front-end and back-end systems, ensuring seamless performance and efficiency',
          salary: '\$800 - \$1000 Salary/Month',
          employment: 'part time',
          imageUrl: 'lib/assets/adham.jpg'
      ),
      Job(
          title: 'Mobile App Developer',
          description: 'Design and develop mobile apps for Android and iOS platforms.',
          salary: '\$700 - \$900 Salary/Month',
          employment: 'full time',
          imageUrl: 'lib/assets/adham.jpg'
      ),
      Job(
          title: 'Backend Developer',
          description: 'Work on server-side applications and APIs for smooth operations.',
          salary: '\$900 - \$1200 Salary/Month',
          employment: 'remote',
          imageUrl: 'lib/assets/adham.jpg'
      ),
      Job(
          title: 'UI/UX Designer',
          description: 'Create user-friendly and visually appealing designs for apps and websites.',
          salary: '\$600 - \$850 Salary/Month',
          employment: 'contract',
          imageUrl: 'lib/assets/adham.jpg'
      ),
    ];
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Hello, Hidaya',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              Text(
                'Adham Company',
                style: TextStyle(color: Color(0xFF191818), fontSize: 14),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 16.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: IconButton(
                    icon: const Icon(
                        Icons.notifications, color: Colors.black, size: 20),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 8),
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('lib/assets/adham.jpg'),
                ),
              ],
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFF0273B1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  '+ Add New Job',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Open Positions',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('See All', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: jobs.length,
                      itemBuilder: (context, index) {
                        return JobCard(job: jobs[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
