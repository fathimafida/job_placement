import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_placement/features/home/cubit/home_cubit.dart';
import 'package:job_placement/features/home/widgets/job_list.dart';

class ViewAllPosts extends StatefulWidget {
  const ViewAllPosts({super.key});

  @override
  State<ViewAllPosts> createState() => _ViewAllPostsState();
}

class _ViewAllPostsState extends State<ViewAllPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View All Posts"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
            if (state is HomeSuccess) {
              return Column(
                children: [
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
                  for (final post in state.postList) JobLists(post: post)
                ],
              );
            }
            return Center(
              child: LinearProgressIndicator(),
            );
          }),
        ),
      )),
    );
  }
}
