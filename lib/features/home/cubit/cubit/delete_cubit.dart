import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'delete_state.dart';

class DeleteCubit extends Cubit<DeleteState> {
  DeleteCubit() : super(DeleteInitial());

  void deleteJobPost({required int postId}) async {
    emit(DeleteLoading());
    try {
      await Dio().delete(
          "https://0410-117-208-30-174.ngrok-free.app/job/posts/$postId");

      emit(DeleteSuccess());
    } catch (e) {
      print(e);
      emit(DeleteError(e.toString()));
    } finally {}
  }
}
