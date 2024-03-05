import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_placement/common/utils/dioClient.dart';
import 'package:job_placement/features/home/models/job_post.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  void getHomeData({String? search}) async {
    emit(HomeLoading());
    try {
      final response = await dioClient.get("/posts",
          queryParameters: {if (search != null) "search": search});
      final List<JobPost> postList = [];
      for (final post in response.data) {
        postList.add(JobPost.fromJson(post));
      }
      emit(HomeSuccess(postList.reversed.toList()));
    } catch (e) {
      print(e);
      emit(HomeError(e.toString()));
    }
  }

  void deletePost({required int id}) async {
    emit(DeletePostLoading());
    try {
      await dioClient.delete(
        "/job/posts/$id/",
      );
      emit(DeletePostSuccess());
    } on DioException catch (e) {
      emit(DeletePostError(e.toString()));
    } catch (e) {
      emit(DeletePostError(e.toString()));
    }
  }
}
