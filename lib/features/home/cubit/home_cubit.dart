import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_placement/features/home/models/post.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  void getHomeData() async {
    emit(HomeLoading());
    try {
      final response = await Dio()
          .get("https://0410-117-208-30-174.ngrok-free.app/job/posts");
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
}
