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
    this.selectedFilter = CourseFilter.all,
    this.searchQuery = '',
  });

  final RequestStatus status;
  final String? errorMessage;
  final List<Course> allCourses;
  final List<Course> popularCourses;
  final List<Course> newestCourses;
  final Course? selectedCourse;
  final CourseFilter selectedFilter;
  final String searchQuery;

  CourseState copyWith({
    String? searchQuery,
    CourseFilter? selectedFilter,
    RequestStatus? status,
    String? errorMessage,
    List<Course>? allCourses,
    List<Course>? popularCourses,
    List<Course>? newestCourses,
    Course? selectedCourse,
  }) {
    return CourseState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      status: status ?? this.status,
      errorMessage: errorMessage,
      allCourses: allCourses ?? this.allCourses,
      popularCourses: popularCourses ?? this.popularCourses,
      newestCourses: newestCourses ?? this.newestCourses,
      selectedCourse: selectedCourse ?? this.selectedCourse,
    );
  }

  List<Course> get filteredCourses {
    switch (selectedFilter) {
      case CourseFilter.all:
        return allCourses;
      case CourseFilter.popular:
        return popularCourses;
      case CourseFilter.newest:
        return newestCourses;
    }
  }

  List<Course> get searchedCourses {
    final courses = filteredCourses;
    if (searchQuery.trim().isEmpty) {
      return courses;
    }

    return courses.where((course) {
      return course.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          course.subtitle.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    allCourses,
    popularCourses,
    newestCourses,
    selectedCourse,
    selectedFilter,
    searchQuery,
  ];
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
