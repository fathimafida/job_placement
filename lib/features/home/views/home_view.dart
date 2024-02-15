// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_placement/common/utils/utils.dart';

import 'package:job_placement/features/addPost/views/add_edit_job_post.dart';

import 'package:job_placement/features/home/cubit/home_cubit.dart';
import 'package:job_placement/features/home/views/view_all_posts.dart';
import 'package:job_placement/features/home/widgets/job_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    // final user = (context.read<AuthCubit>().state as AuthSuccess).user;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                  final first3Posts = state.postList.take(3).toList();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Find Your Dream',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              Text('Job With Us ',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              navigateTO(context, AddEditJobPost());
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 3, bottom: 3),
                              width: 55,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.3),
                                  border: Border.all()),
                              child: Icon(
                                Icons.add,
                                size: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Text(
                            'Featured Jobs',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Spacer(),
                          TextButton.icon(
                            onPressed: () {
                              navigateTO(context, ViewAllPosts());
                            },
                            label: Text(
                              'Show all',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                            ),
                            icon: Icon(
                              Icons.arrow_forward,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                      Column(children: [
                        for (var post in first3Posts) JobLists(post: post),
                      ]),
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
