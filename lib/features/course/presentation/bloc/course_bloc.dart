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
  }

  final GetCourses _getCourses;
  final GetCourseById _getCourseById;

  Future<void> _onLoadCourses(LoadCourses event, Emitter<CourseState> emit) async {
    emit(state.copyWith(status: RequestStatus.loading));

    final result = await _getCourses(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: RequestStatus.failure, errorMessage: failure.message)),
      (courses) => emit(state.copyWith(status: RequestStatus.success, allCourses: courses)),
    );
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
