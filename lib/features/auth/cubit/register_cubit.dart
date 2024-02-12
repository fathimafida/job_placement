import 'package:bloc/bloc.dart';
import 'package:job_placement/common/utils/dioClient.dart';
import 'package:job_placement/features/auth/models/user.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  void registerUser(
      {required String name,
      required String email,
      required String password}) async {
    emit(RegisterLoading());
    try {
      final resp = await dioClient.post("/job/register/",
          data: {"name": name, "email": email, "password": password});
      emit(RegisterSuccess(User.fromJson(resp.data)));
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
