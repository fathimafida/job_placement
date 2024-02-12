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
                  // Call the appropriate method based on whether the search field is empty or not.
                  if (value.isEmpty) {
                    // When search is cleared, fetch all data again.
                    context.read<HomeCubit>().getHomeData();
                  } else {
                    // When there is a search term, fetch filtered data.
                    context.read<HomeCubit>().getHomeData(search: value);
                  }
                },
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search jobs here.....',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
                if (state is HomeSuccess) {
                  return Column(
                    children: [
                      for (final post in state.postList) JobLists(post: post)
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
