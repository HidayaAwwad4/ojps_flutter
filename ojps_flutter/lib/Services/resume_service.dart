import '../models/resume_model.dart';

class ResumeService {
  static Future<ResumeModel> fetchResumeData() async {
    // Simulate fetching from DB or local storage
    return ResumeModel(
      fullName: "Lorem ipsum",
      email: "Lorem.ipsum112@example.com",
      location: "palestine, Nablus",
      phone: "+970592222222",
      summary: "Detail-oriented software engineer with 4+ years of experience...",
      imageUrl: "", // Use default avatar
      workExperiences: [
        Experience(
          "Marketing Coordinator",
          "ABC Digital Agency",
          "Jan 2022 to Present",
          "• Developed campaigns\n• Increased engagement...",
        ),
        Experience(
          "Software Developer",
          "TechNova Ltd",
          "Jun 2020 to Dec 2022",
          "• Built and maintained web apps\n• Integrated REST APIs...",
        )
      ],
      educations: [
        Education(
          "B.Sc. in Computer Science",
          "NNU University",
          "Sep 2019 to Jun 2023",
          "• Graduated with Honors\n• Relevant courses: Data Structures...",
        )
      ],
    );
  }

  static Future<bool> checkUploadedResumeFile() async {
    // Return true if file is uploaded in ManageResume
    return true; // simulate uploaded
  }

  static void downloadResumeFile() {
    // Trigger file download
    print("Downloading file...");
  }
}
