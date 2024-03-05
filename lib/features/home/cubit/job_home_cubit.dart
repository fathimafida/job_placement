import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:job_placement/common/utils/dioClient.dart';
import 'package:job_placement/features/home/models/job_post.dart';
import 'package:meta/meta.dart';

part 'job_home_state.dart';

class JobHomeCubit extends Cubit<JobHomeState> {
  JobHomeCubit() : super(JobHomeInitial());
  void getJobHomeData() async {
    emit(JobHomeLoading());
    try {
      final response = await dioClient.get(
        "/job/home/",
      );
      final List<JobPost> latestJobs = [
        for (final post in response.data['latest3Jobs']) JobPost.fromJson(post),
      ];
      final List<JobPost> bestInternships = [
        for (final post in response.data['best3Internships'])
          JobPost.fromJson(post),
      ];

      emit(JobHomeSuccess(latestJobs, bestInternships));
    } catch (e) {
      print(e);
      emit(JobHomeError(e.toString()));
    }
  }

  // void deletePost({required int id}) async {
  //   emit(DeletePostLoading());
  //   try {
  //     await dioClient.delete(
  //       "/job/posts/$id/",
  //     );
  //     emit(DeletePostSuccess());
  //   } on DioException catch (e) {
  //     emit(DeletePostError(e.toString()));
  //   } catch (e) {
  //     emit(DeletePostError(e.toString()));
  //   }
  // }
}
