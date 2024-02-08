import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_placement/common/utils/dioClient.dart';
import 'package:job_placement/features/home/models/post.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  void getHomeData({String? search}) async {
    emit(HomeLoading());
    try {
      final response = await dioClient.get("/job/posts",
          queryParameters: {if (search != null) "search": search});
      final List<Post> postList = [];
      for (final post in response.data) {
        postList.add(Post.fromJson(post));
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
      print(e.response?.data);
      print(e);
      print(e.error);
      emit(DeletePostError(e.toString()));
    } catch (e) {
      print(e);
      emit(DeletePostError(e.toString()));
    }
  }
}
