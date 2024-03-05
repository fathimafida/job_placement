part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<JobPost> postList;
  HomeSuccess(this.postList);
}

final class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

final class DeletePostLoading extends HomeState {}

final class DeletePostSuccess extends HomeState {}

final class DeletePostError extends HomeState {
  final String message;
  DeletePostError(this.message);
}
