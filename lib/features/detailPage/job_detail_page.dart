import 'package:flutter/material.dart';
import 'package:job_placement/common/utils/utils.dart';

class JobDetailsPage extends StatelessWidget {
  const JobDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job details"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Junior Mobile Application Developer",
                      style: applyTextStyle(20, FontWeight.bold),
                    ),
                    ListTile(
                      title: Text("Hybrid Full Time"),
                      leading: Icon(Icons.shopping_bag),
                    ),
                    ListTile(
                      title: Text("1-10 employees"),
                      leading: Icon(Icons.calendar_month),
                    ),
                    ListTile(
                      title: Text(
                          "Skills Mobile Application Developer,dart,Flutter"),
                      leading: Icon(Icons.work),
                    ),
                    ListTile(
                      title: Text("Applicant review time is 10 days"),
                      leading: Icon(Icons.verified),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "About the job",
                      style: applyTextStyle(18, FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                        "A Flutter Mobile App Developer creates cross-platform apps using Flutter and Dart. Responsibilities include collaborating on UI/UX design, integrating backend services, and ensuring app performance. Thorough testing, problem-solving, and staying updated on industry trends are essential. Effective communication is crucial for collaboration with other developers and stakeholders, aiming to deliver high-quality mobile applications.",
                        style: applyTextStyle(16, FontWeight.normal)),
                    SizedBox(height: 10),
                    Text(
                      "Key responsibilities",
                      style: applyTextStyle(18, FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ...List.generate(
                      8,
                      (index) => Text(
                        "${index + 1}. <Responsibility description here>",
                        style: applyTextStyle(16, FontWeight.normal),
                      ),
                    ),
                    SizedBox(height: 80), // Add space for the floating button
                  ],
                ),
              ),
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Apply Now",
                      style: applyTextStyle(16, FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(150, 50),
                      backgroundColor: Color.fromARGB(255, 1, 27, 72),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
