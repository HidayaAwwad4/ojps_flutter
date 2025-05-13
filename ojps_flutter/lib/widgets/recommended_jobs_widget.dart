import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/screens/job_details_job_seeker_screen.dart';

class RecommendedJobsWidget extends StatelessWidget {
  const RecommendedJobsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        JobCard(
          image: 'assets/adham.jpg',
          title: 'Full-Stack Developer',
          location: 'Nablus-Rafidia',
          type: 'Full-Time',
          description: 'Responsible for developing front-end and back-end systems.',
          salary: '\$800 - \$1000 Salary/Month',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const JobDetailsJobSeekerScreen(),
              ),
            );
          },
        ),
        JobCard(
          image: 'assets/adham.jpg',
          title: 'UI/UX Designer',
          location: 'Ramallah',
          type: 'Part-Time',
          description: 'Design user interfaces with a focus on usability and beauty.',
          salary: '\$500 - \$800 Salary/Month',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const JobDetailsJobSeekerScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class JobCard extends StatefulWidget {
  final String image;
  final String title;
  final String location;
  final String type;
  final String description;
  final String salary;
  final VoidCallback onTap;

  const JobCard({
    super.key,
    required this.image,
    required this.title,
    required this.location,
    required this.type,
    required this.description,
    required this.salary,
    required this.onTap,
  });

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: primaryColor.withOpacity(0.2),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cardBackgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      widget.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: primaryTextColor,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                isSaved ? Icons.bookmark : Icons.bookmark_border,
                                color: primaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  isSaved = !isSaved;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${widget.location} • ${widget.type}",
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 12,
                  color: secondaryTextColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.salary,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
