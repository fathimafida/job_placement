import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_placement/common/utils/utils.dart';
import 'package:job_placement/features/addPost/views/add_edit_job_post.dart';
import 'package:job_placement/features/detailPage/views/job_detail_page.dart';
import 'package:job_placement/features/home/cubit/home_cubit.dart';
import 'package:intl/intl.dart';
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
      child: Card(
        elevation: 0,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 5,
                child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            image: NetworkImage(widget.post.image),
                            fit: BoxFit.cover))),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.title,
                      style: applyTextStyle(12, FontWeight.bold),
                    ),
                    Text(
                      widget.post.companyName,
                      style: applyTextStyle(10, FontWeight.normal),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 12,
                        ),
                        SizedBox(width: 5),
                        Text(
                          widget.post.place,
                          style: applyTextStyle(10, FontWeight.normal),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        DateFormat('dd-MM-yyyy  hh:mm a').format(DateTime.parse(
                          widget.post.createdAt,
                        ).toLocal()),
                        style: applyTextStyle(8, FontWeight.w100)),
                  ],
                ),
              ),
              PopupMenuButton(
                  iconSize: 15,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                          textStyle: TextStyle(fontSize: 15),
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
                              SizedBox(width: 8),
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
                            SizedBox(width: 8),
                            Text('Delete'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                          child: Row(
                        children: [
                          Icon(Icons.bookmark_outline),
                          SizedBox(width: 8),
                          Text('Save'),
                        ],
                      )),
                      const PopupMenuItem(
                          child: Row(
                        children: [
                          Icon(Icons.flag_outlined),
                          SizedBox(width: 8),
                          Text('Report '),
                        ],
                      )),
                    ];
                  }),
            ],
          ),
        ]),
      ),
    );
  }
}
