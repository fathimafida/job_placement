import 'package:flutter/material.dart';
import 'package:job_placement/common/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:job_placement/features/home/models/post.dart';

import 'web_view_screen.dart';

class JobDetailsPage extends StatelessWidget {
  const JobDetailsPage({super.key, required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job details"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(),
                                image: DecorationImage(
                                    image: NetworkImage(post.image),
                                    fit: BoxFit.cover)),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            post.title,
                            style: applyTextStyle(20, FontWeight.bold),
                          ),
                          Text("${post.companyName} - ${post.place}",
                              style: applyTextStyle(15, FontWeight.normal)),
                        ],
                      )),
                      const SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Icon(
                              Icons.shopping_bag,
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(post.jobType,
                                style: applyTextStyle(15, FontWeight.bold))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Job Description",
                        style: applyTextStyle(20, FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(post.description,
                          style: applyTextStyle(16, FontWeight.normal)),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  navigateTO(
                      context,
                      WebViewScreen(
                        url: post.url,
                      ));
                },
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
