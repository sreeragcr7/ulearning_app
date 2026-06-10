part of 'course_bloc.dart';

@immutable
sealed class CourseEvent {
  const CourseEvent();
}

final class LoadCourses extends CourseEvent {}

// final class LoadPopularCourses extends CourseEvent {}

// final class LoadNewestCourses extends CourseEvent {}

final class LoadCourseDetails extends CourseEvent {
  const LoadCourseDetails(this.courseId);
  final String courseId;
}

final class ChangeCourseFilter extends CourseEvent {
  const ChangeCourseFilter(this.filter);
  final CourseFilter filter;
}

final class SearchCourse extends CourseEvent {
  const SearchCourse(this.query);
  final String query;
}
