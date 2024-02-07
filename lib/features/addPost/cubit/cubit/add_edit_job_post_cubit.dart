import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_placement/features/home/models/post.dart';

part 'add_job_edit_post_state.dart';

class AddEditJobPostCubit extends Cubit<AddJobPostState> {
  AddEditJobPostCubit() : super(AddEditJobPostInitial());
  void addJobPost(
      {required String title,
      required String description,
      required String place,
      XFile? image,
      required String companyName}) async {
    emit(AddEditJobPostLoading());
    try {
      final formData = FormData.fromMap({
        "title": title,
        "description": description,
        "place": place,
        "companyName": companyName,
        if (image != null)
          "image": await MultipartFile.fromFile(
            image.path,
            filename: image.name,
          )
      });
      print("before");
      final response = await Dio().post(
          "https://0410-117-208-30-174.ngrok-free.app/job/posts/",
          data: formData);

      print("after");
      print(response.data);
      emit(AddEditJobPostSuccess());
    } on DioException catch (e) {
      print(e);
      print(e.response?.data?.toString());
      emit(AddEditJobPostError(e.toString()));
    } catch (e) {
      print(e);
      emit(AddEditJobPostError(e.toString()));
    }
  }

  void editJobPost(
      {required String title,
      required String description,
      required String place,
      required Post post,
      XFile? image,
      required String companyName}) async {
    emit(AddEditJobPostLoading());
    try {
      final formData = FormData.fromMap({
        "title": title,
        "description": description,
        "place": place,
        "companyName": companyName,
        if (image != null)
          "image": await MultipartFile.fromFile(
            image.path,
            filename: image.name,
          )
      });
      print("before");
      final response = await Dio().patch(
          "https://0410-117-208-30-174.ngrok-free.app/job/posts/${post.id}",
          data: formData);
      emit(AddEditJobPostSuccess());
    } on DioException catch (e) {
      print(e);
      print(e.response?.data?.toString());
      emit(AddEditJobPostError(e.toString()));
    } catch (e) {
      print(e);
      emit(AddEditJobPostError(e.toString()));
    }
  }
}
