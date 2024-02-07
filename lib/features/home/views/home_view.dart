// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_placement/common/utils/utils.dart';
import 'package:job_placement/features/detailPage/job_detail_page.dart';
import 'package:job_placement/features/addPost/views/add_edit_job_post.dart';
import 'package:job_placement/features/home/cubit/cubit/delete_cubit.dart';
import 'package:job_placement/features/home/cubit/home_cubit.dart';
import 'package:job_placement/features/home/models/post.dart';
import 'package:job_placement/features/home/widgets/job_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is DeleteSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Deleted successfully")));
                context.read<HomeCubit>().getHomeData();
              }
              if (state is DeleteError) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Can't delete job post")));
              }
            },
            builder: (context, state) {
              return Column(
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
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
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
              );
            },
          ),
        ),
      )),
    );
  }
}
