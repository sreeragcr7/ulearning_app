import 'package:equatable/equatable.dart';
import 'package:ulearning_app/core/common/entities/course.dart';
import 'package:ulearning_app/core/utils/constants/enums.dart';

class CourseState extends Equatable {
  const CourseState({
    this.status = RequestStatus.initial,
    this.errorMessage,
    this.allCourses = const [],
    this.popularCourses = const [],
    this.newestCourses = const [],
    this.selectedCourse,
  });

  final RequestStatus status;
  final String? errorMessage;
  final List<Course> allCourses;
  final List<Course> popularCourses;
  final List<Course> newestCourses;
  final Course? selectedCourse;

  CourseState copyWith({
    RequestStatus? status,
    String? errorMessage,
    List<Course>? allCourses,
    List<Course>? popularCourses,
    List<Course>? newestCourses,
    Course? selectedCourse,
  }) {
    return CourseState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      allCourses: allCourses ?? this.allCourses,
      popularCourses: popularCourses ?? this.popularCourses,
      newestCourses: newestCourses ?? this.newestCourses,
      selectedCourse: selectedCourse ?? this.selectedCourse,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, allCourses, popularCourses, newestCourses, selectedCourse];
}

// final class CourseInitial extends CourseState {}

// final class CourseLoading extends CourseState {}

// final class CourseLoaded extends CourseState {
//   const CourseLoaded(this.courses);
//   final List<Course> courses;
// }

// final class PopularCoursesLoaded extends CourseState {
//   const PopularCoursesLoaded(this.courses);
//   final List<Course> courses;
// }

// final class NewestCoursesLoaded extends CourseState {
//   const NewestCoursesLoaded(this.courses);
//   final List<Course> courses;
// }

// final class CourseDetailsLoaded extends CourseState {
//   const CourseDetailsLoaded(this.course);
//   final Course course;
// }

// final class CourseFailure extends CourseState {
//   const CourseFailure(this.message);
//   final String message;
// }
