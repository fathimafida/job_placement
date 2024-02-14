// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:job_placement/common/utils/utils.dart';

import 'package:job_placement/features/home/models/post.dart';

import 'web_view_screen.dart';

class JobDetailsPage extends StatelessWidget {
  const JobDetailsPage({super.key, required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Job details"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Column(
                        children: [
                          // Container(
                          //   padding: EdgeInsets.all(10),
                          //   height: 250,
                          //   width: double.infinity,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(15),
                          //       border: Border.all(),
                          //       image: DecorationImage(
                          //           image: NetworkImage(post.image),
                          //           fit: BoxFit.cover)),
                          // ),
                          CircleAvatar(
                            radius: 85,
                            backgroundImage: NetworkImage(
                              post.image,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            post.title,
                            style: applyTextStyle(18, FontWeight.bold),
                          ),
                          Text("${post.companyName} - ${post.place}",
                              style: applyTextStyle(14, FontWeight.normal)),
                        ],
                      )),
                      const SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Icon(
                              Icons.business_center,
                              size: 25,
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(post.jobType,
                                style: applyTextStyle(16, FontWeight.normal))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Job Description",
                        style: applyTextStyle(18, FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(post.description,
                          style: applyTextStyle(14, FontWeight.normal)),
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
                  style: applyTextStyle(20, FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(180, 50),
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  foregroundColor: Theme.of(context).colorScheme.onBackground,
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
