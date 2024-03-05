import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:job_placement/features/home/cubit/job_home_cubit.dart';

import 'package:job_placement/features/home/widgets/job_list.dart';

class ViewAllPosts extends StatefulWidget {
  const ViewAllPosts({super.key});

  @override
  State<ViewAllPosts> createState() => _ViewAllPostsState();
}

class _ViewAllPostsState extends State<ViewAllPosts> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Posts"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  context.read<JobHomeCubit>().getJobHomeData();
                },
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search jobs here.....',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<JobHomeCubit, JobHomeState>(
                  builder: (context, state) {
                if (state is JobHomeSuccess) {
                  return Column(
                    children: [
                      for (final post in state.latestJobs)
                        JobListTile(post: post)
                    ],
                  );
                }
                return const Center(
                  child: LinearProgressIndicator(),
                );
              }),
            ],
          ),
        ),
      )),
    );
  }
}
