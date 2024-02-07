part of 'add_edit_job_post_cubit.dart';

@immutable
sealed class AddJobPostState {}

final class AddEditJobPostInitial extends AddJobPostState {}

final class AddEditJobPostLoading extends AddJobPostState {}

final class AddEditJobPostSuccess extends AddJobPostState {}

final class AddEditJobPostError extends AddJobPostState {
  final String error;
  AddEditJobPostError(this.error);
}
