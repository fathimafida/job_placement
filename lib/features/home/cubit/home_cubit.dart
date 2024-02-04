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
      final response = await Dio().get("http://127.0.0.1:8000/posts/");
      final List<Post> postList = [];
      for (final post in response.data) {
        postList.add(Post.fromJson(post));
      }
      emit(HomeSuccess(postList));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
