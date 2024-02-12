import 'package:bloc/bloc.dart';
import 'package:job_placement/common/utils/dioClient.dart';
import 'package:job_placement/features/auth/models/user.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void loginUser({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      print("before");
      final user = await dioClient
          .post("/job/login/", data: {"email": email, "password": password});
      print("after");
      emit(AuthSuccess(User.fromJson(user.data)));
    } catch (e) {
      print(e);
      emit(AuthError(e.toString()));
    }
  }
}
