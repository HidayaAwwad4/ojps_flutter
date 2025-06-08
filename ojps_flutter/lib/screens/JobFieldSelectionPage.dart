import 'package:flutter/material.dart';

class JobFieldSelectionPage extends StatelessWidget {
  final List<Map<String, String>> fields = [
    {'title': 'Marketing', 'image': 'assets/markiting.jpg'},
    {'title': 'Technology', 'image': 'assets/tech.jpg'},
    {'title': 'Design', 'image': 'assets/design.jpg'},
    {'title': 'Sales', 'image': 'assets/sales.jpg'},
    {'title': 'Cooking', 'image': 'assets/cooking.jpg'},
    {'title': 'Other', 'image': 'assets/other.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xFF0273B1);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'HIRUZA',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Find a job in your field',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              SizedBox(height: 30),
              Expanded(
                child: GridView.builder(
                  itemCount: fields.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two items per row
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 3 / 4,
                  ),
                  itemBuilder: (context, index) {
                    final field = fields[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/home-page');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 5,
                              offset: Offset(2, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                child: Image.asset(
                                  field['image']!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                field['title']!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
