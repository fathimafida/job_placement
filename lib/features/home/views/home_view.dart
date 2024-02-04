// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_placement/common/utils/utils.dart';
import 'package:job_placement/features/detailPage/job_detail_page.dart';
import 'package:job_placement/features/addPost/add_post_job.dart';
import 'package:job_placement/features/home/cubit/home_cubit.dart';
import 'package:job_placement/features/home/models/post.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Find Your Dream Job With Us',
                    style: applyGoogleFontToText(
                      20,
                    ),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all()),
                    child: IconButton(
                      onPressed: () {
                        navigateTO(context, PostJob());
                      },
                      icon: Icon(Icons.add),
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search jobs here.....',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Campus Placement',
                style: applyGoogleFontToText(20),
              ),
              SizedBox(
                height: 20,
              ),
              BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is HomeSuccess) {
                    return Column(
                      children: [
                        for (final post in state.postList)
                          JobLists(
                            post: post,
                          ),
                      ],
                    );
                  }
                  return Center(
                    child: LinearProgressIndicator(),
                  );
                },
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: TextButton.icon(
                  onPressed: () {},
                  label: Text('View all'),
                  icon: Icon(Icons.arrow_forward),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class JobLists extends StatelessWidget {
  const JobLists({
    super.key,
    required this.post,
  });
  final Post post;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTO(context, JobDetailsPage());
      },
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.title,
                        style: applyTextStyle(18, FontWeight.bold),
                      ),
                      Text(
                        post.companyName,
                        style: applyTextStyle(14, FontWeight.normal),
                      ),
                      Text(
                        post.place,
                        style: applyTextStyle(14, FontWeight.w100),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
                top: 0,
                right: 0,
                child: PopupMenuButton(itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        child: Row(
                      children: [
                        Icon(Icons.bookmark_outline),
                        Text('Save'),
                      ],
                    )),
                    PopupMenuItem(
                        child: Row(
                      children: [
                        Icon(Icons.flag_outlined),
                        Text('Report '),
                      ],
                    )),
                  ];
                })),
          ],
        ),
        Divider(),
      ]),
    );
  }
}
