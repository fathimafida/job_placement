import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_placement/common/utils/utils.dart';
import 'package:job_placement/features/addPost/views/add_edit_job_post.dart';
import 'package:job_placement/features/detailPage/views/job_detail_page.dart';
import 'package:job_placement/features/home/cubit/home_cubit.dart';

import 'package:job_placement/features/home/models/post.dart';

class JobLists extends StatefulWidget {
  const JobLists({
    super.key,
    required this.post,
  });
  final Post post;

  @override
  State<JobLists> createState() => _JobListsState();
}

class _JobListsState extends State<JobLists> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTO(context, JobDetailsPage(post: widget.post));
      },
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(widget.post.image),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.title,
                        style: applyTextStyle(18, FontWeight.bold),
                      ),
                      Text(
                        widget.post.companyName,
                        style: applyTextStyle(14, FontWeight.normal),
                      ),
                      Text(
                        widget.post.place,
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
                        onTap: () {
                          navigateTO(
                              context,
                              AddEditJobPost(
                                post: widget.post,
                              ));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.edit_outlined),
                            Text('Edit'),
                          ],
                        )),
                    PopupMenuItem(
                      onTap: () {
                        context
                            .read<HomeCubit>()
                            .deletePost(id: widget.post.id);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline),
                          Text('Delete'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                        child: Row(
                      children: [
                        Icon(Icons.bookmark_outline),
                        Text('Save'),
                      ],
                    )),
                    const PopupMenuItem(
                        child: Row(
                      children: [
                        Icon(Icons.flag_outlined),
                        Text('Report '),
                      ],
                    )),
                  ];
                }))
          ],
        ),
        const Divider(),
      ]),
    );
  }
}
