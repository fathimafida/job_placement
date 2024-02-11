// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_placement/common/utils/utils.dart';

import 'package:job_placement/features/addPost/views/add_edit_job_post.dart';

import 'package:job_placement/features/home/cubit/home_cubit.dart';
import 'package:job_placement/features/home/views/view_all_posts.dart';
import 'package:job_placement/features/home/widgets/job_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<HomeCubit>().getHomeData();
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: BlocConsumer<HomeCubit, HomeState>(
                  listener: (context, state) {
                if (state is DeletePostSuccess) {
                  context.read<HomeCubit>().getHomeData();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Post Deleted Successfully"),
                  ));
                }
                if (state is DeletePostError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message),
                  ));
                }
              }, builder: (context, state) {
                if (state is HomeSuccess) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Find Your Dream',
                                style: applyGoogleFontToText(
                                  20,
                                ),
                              ),
                              Text(
                                'Job With Us ',
                                style: applyGoogleFontToText(
                                  20,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                )),
                            child: IconButton(
                              onPressed: () {
                                navigateTO(context, AddEditJobPost());
                              },
                              icon: Icon(Icons.add),
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Featured Jobs',
                        style: applyGoogleFontToText(20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(children: [
                        JobLists(post: state.postList[0]),
                        JobLists(post: state.postList[1]),
                        JobLists(post: state.postList[2]),
                      ]),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton.icon(
                          onPressed: () {
                            navigateTO(context, ViewAllPosts());
                          },
                          label: Text('Show all'),
                          style: TextButton.styleFrom(
                            foregroundColor: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),
                          icon: Icon(Icons.arrow_forward),
                        ),
                      ),
                      SizedBox(height: 18),
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.file_upload_outlined,
                      //       size: 35,
                      //     ),
                      //     SizedBox(
                      //       width: 15,
                      //     ),
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text("Upload Your resume",
                      //             style: applyTextStyle(16, FontWeight.bold)),
                      //         Text(
                      //             "We'll match you with the best suitable jobs",
                      //             style: applyTextStyle(15, FontWeight.normal))
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       width: 70,
                      //     ),
                      //     TextButton.icon(
                      //         onPressed: () {},
                      //         icon: Icon(
                      //           Icons.file_upload_outlined,
                      //           size: 25,
                      //         ),
                      //         label: Text("Upload from device",
                      //             style: applyTextStyle(18, FontWeight.bold))),
                      //   ],
                      // )
                    ],
                  );
                }
                return Center(
                  child: LinearProgressIndicator(),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
