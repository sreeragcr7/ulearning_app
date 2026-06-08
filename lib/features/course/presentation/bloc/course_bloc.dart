import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/core/usecases/t_usecase.dart';
import 'package:ulearning_app/core/utils/constants/enums.dart';
import 'package:ulearning_app/features/course/domain/usecases/get_courses.dart';
import 'package:ulearning_app/features/course/presentation/bloc/course_state.dart';

part 'course_event.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc({required GetCourses getCourses}) : _getCourses = getCourses, super(const CourseState()) {
    on<LoadCourses>(_onLoadCourses);
  }

  final GetCourses _getCourses;

  Future<void> _onLoadCourses(LoadCourses event, Emitter<CourseState> emit) async {
    emit(state.copyWith(status: CourseStatus.loading));

    final result = await _getCourses(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: CourseStatus.failure, errorMessage: failure.message)),
      (courses) => emit(state.copyWith(status: CourseStatus.success, allCourses: courses)),
    );
  }
}
