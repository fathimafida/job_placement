part of 'job_home_cubit.dart';

@immutable
sealed class JobHomeState {}

final class JobHomeInitial extends JobHomeState {}

final class JobHomeLoading extends JobHomeState {}

final class JobHomeSuccess extends JobHomeState {
  final List<JobPost> latestJobs;
  final List<JobPost> bestInternships;

  JobHomeSuccess(this.latestJobs, this.bestInternships);
}

final class JobHomeError extends JobHomeState {
  final String message;
  JobHomeError(this.message);
}
