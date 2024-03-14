// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:job_placement/common/utils/utils.dart';
import 'package:job_placement/features/add_edit_job_post/cubit/cubit/manage_job_cubit.dart';
import 'package:job_placement/features/add_edit_job_post/views/add_edit_job_post.dart';
import 'package:job_placement/features/detailPage/views/web_view_screen.dart';
import 'package:job_placement/features/home/models/job_post.dart';

class JobDetailScreen extends StatefulWidget {
  const JobDetailScreen({super.key, required this.post});
  final JobPost post;

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Job details"),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                navigateTO(
                    context,
                    AddEditJobPostScreen(
                      post: widget.post,
                    ));
              },
              icon: const Icon(Icons.create_outlined),
            ),
            IconButton(
              onPressed: () {
                context.read<ManageJobCubit>().deleteJob(id: widget.post.id!);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete_outline),
            )
          ]),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Column(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(widget.post.image ?? ""),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.post.title!,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "${widget.post.companyName} - ${widget.post.place}",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                )),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceVariant
                        .withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.business_center,
                        size: 25,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                          "${widget.post.jobType} - ${widget.post.jobLocationType}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                SizedBox(
                  height: 15,
                ),
                Text(
                  widget.post.description!,
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      navigateTO(context, WebViewScreen(url: widget.post.url!));
                    },
                    child: Text(
                      "Apply Now",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(180, 50),
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      foregroundColor:
                          Theme.of(context).colorScheme.onBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
