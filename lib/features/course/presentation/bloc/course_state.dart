part of 'course_bloc.dart';

@immutable
sealed class CourseState {
  const CourseState();
}

final class CourseInitial extends CourseState {}

final class CourseLoading extends CourseState {}

final class CourseLoaded extends CourseState {
  const CourseLoaded(this.courses);
  final List<Course> courses;
}

final class CourseDetailsLoaded extends CourseState {
  const CourseDetailsLoaded(this.course);
  final Course course;
}

final class CourseFailure extends CourseState {
  const CourseFailure(this.message);
  final String message;
}
