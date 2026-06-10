import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/core/usecases/t_usecase.dart';
import 'package:ulearning_app/core/utils/constants/enums.dart';
import 'package:ulearning_app/features/course/domain/usecases/get_course_by_id.dart';
import 'package:ulearning_app/features/course/domain/usecases/get_courses.dart';
import 'package:ulearning_app/features/course/presentation/bloc/course_state.dart';

part 'course_event.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc({required GetCourses getCourses, required GetCourseById getCourseById})
    : _getCourses = getCourses,
      _getCourseById = getCourseById,
      super(const CourseState()) {
    on<LoadCourses>(_onLoadCourses);
    on<LoadCourseDetails>(_onLoadCourseDetails);
    on<ChangeCourseFilter>(_onChangeCourseFilter);
    on<SearchCourse>(_onSearchCourse);
  }

  final GetCourses _getCourses;
  final GetCourseById _getCourseById;

  Future<void> _onSearchCourse(SearchCourse event, Emitter<CourseState> emit) async {
    emit(state.copyWith(searchQuery: event.query));
  }

  Future<void> _onChangeCourseFilter(ChangeCourseFilter event, Emitter<CourseState> emit) async {
    emit(state.copyWith(selectedFilter: event.filter));
  }

  Future<void> _onLoadCourses(LoadCourses event, Emitter<CourseState> emit) async {
    emit(state.copyWith(status: RequestStatus.loading));

    final result = await _getCourses(NoParams());
    result.fold((failure) => emit(state.copyWith(status: RequestStatus.failure, errorMessage: failure.message)), (
      courses,
    ) {
      final popularCourses = courses.where((course) => course.isPopular).toList();
      final newestCourses = [...courses]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      emit(
        state.copyWith(
          status: RequestStatus.success,
          allCourses: courses,
          popularCourses: popularCourses,
          newestCourses: newestCourses,
        ),
      );
    });
  }

  Future<void> _onLoadCourseDetails(LoadCourseDetails event, Emitter<CourseState> emit) async {
    emit(state.copyWith(status: RequestStatus.loading));

    final result = await _getCourseById(event.courseId);

    result.fold(
      (failure) => emit(state.copyWith(status: RequestStatus.failure, errorMessage: failure.message)),
      (course) => emit(state.copyWith(status: RequestStatus.success, selectedCourse: course)),
    );
  }
}
