import '../models/resume_model.dart';

class ResumeService {
  static Future<ResumeModel> fetchResume() async {
    return ResumeModel(
      fullName: "Lorem ipsum",
      email: "Lorem.ipsum112@example.com",
      location: "palestine, Nablus",
      phone: "+970592222222",
      summary: "Detail-oriented software engineer with 4+ years of experience...",
      imageUrl: "", // Use default avatar
      experiences: [
        Experience(
          jobTitle: "Marketing Coordinator",
          company: "ABC Digital Agency",
          startDate: "Jan 2022 ",
          endDate: "to Present",
          bulletPoint: "• Developed campaigns\n• Increased engagement...",
        ),
        Experience(
          jobTitle: "Software Developer",
          company: "TechNova Ltd",
          startDate: "Jun 2020 ",
          endDate: "to Dec 2022",
          bulletPoint: "• Built and maintained web apps\n• Integrated REST APIs...",
        )
      ],
      educations: [
        Education(
          degree: "Bachelor",
          institution: "NNU University",
          startDate: "Sep 2019 ",
          endDate: "to Jun 2023",
          gpa: "3.85",
          honors: "• Graduated with Honors\n• Relevant courses: Data Structures...",
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