import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:job_placement/common/utils/dioClient.dart';
import 'package:job_placement/features/auth/models/user.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void loginUser({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      final user = await Dio().post("https://stuverse.in/api/user/login/",
          data: {"email": email, "password": password});

      emit(AuthSuccess(User.fromJson(user.data)));
    } catch (e) {
      print(e);
      emit(AuthError(e.toString()));
    }
  }
}
