import 'package:flutter/material.dart';
import 'package:job_placement/common/utils/common_utils.dart';
import 'package:job_placement/features/detailPage/views/job_detail_page.dart';
import 'package:job_placement/features/home/models/job_post.dart';

class JobListTile extends StatefulWidget {
  const JobListTile({
    super.key,
    required this.post,
  });
  final JobPost post;

  @override
  State<JobListTile> createState() => _JobListTileState();
}

class _JobListTileState extends State<JobListTile> {
  @override
  Widget build(BuildContext context) {
    // final user = context.read<CoreCubit>().state.user;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JobDetailScreen(post: widget.post),
            ));
      },
      child: Card(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.6),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 5,
                  child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image: NetworkImage(widget.post.image ?? ""),
                              fit: BoxFit.cover))),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.title ?? "no title",
                      ),
                      Text(widget.post.companyName ?? "no company name"),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.post.place ?? "no place",
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          CommonUtils.relativeTime(
                            widget.post.createdAt,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // if (user?.type == UserTypes.ADMIN ||
                //     user?.type == UserTypes.FACULTY)
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
