import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:job_placement/features/add_edit_job_post/cubit/cubit/manage_job_cubit.dart';

import 'package:job_placement/features/home/cubit/job_home_cubit.dart';
import 'package:job_placement/features/home/widgets/job_list.dart';

class JobHomeScreen extends StatefulWidget {
  const JobHomeScreen({super.key});

  @override
  State<JobHomeScreen> createState() => _JobHomeScreenState();
}

class _JobHomeScreenState extends State<JobHomeScreen> {
  @override
  void initState() {
    context.read<JobHomeCubit>().getJobHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ManageJobCubit, ManageJobState>(
        listener: (context, state) {
          if (state is ManageJobSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));

            context.read<JobHomeCubit>().getJobHomeData();

            // context.go(JobRoutes.jobHome);
          }
          if (state is ManageJobError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          }
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<JobHomeCubit>().getJobHomeData();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: BlocConsumer<JobHomeCubit, JobHomeState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is JobHomeSuccess) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Find Your Dream',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold)),
                                    Text('Job With Us ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    // context.push(JobRoutes.jobAddEdit);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(top: 4, bottom: 4),
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
                            SizedBox(
                              height: 10,
                            ),
                            Hero(
                              tag: 'jobSearch',
                              child: Material(
                                child: InkWell(
                                  onTap: () {
                                    // context.push(JobRoutes.jobSearch);
                                  },
                                  child: IgnorePointer(
                                    ignoring: true,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.search),
                                        hintText: 'Search jobs here.....',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Featured Jobs',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Spacer(),
                                TextButton.icon(
                                  onPressed: () {
                                    // context.push(JobRoutes.jobSearch);
                                  },
                                  label: Text(
                                    'Show all',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
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
                              for (var post in state.latestJobs)
                                JobListTile(post: post),
                            ]),
                            Row(
                              children: [
                                Text(
                                  'Best Internship Jobs',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Spacer(),
                                TextButton.icon(
                                  onPressed: () {
                                    // context.push(JobRoutes.jobSearch);
                                  },
                                  label: Text(
                                    'Show all',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
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
                              for (var post in state.bestInternships)
                                JobListTile(post: post),
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
      ),
    );
  }
}
