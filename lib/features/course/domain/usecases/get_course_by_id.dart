import 'package:fpdart/fpdart.dart';
import 'package:ulearning_app/core/common/entities/course.dart';
import 'package:ulearning_app/core/error/failures.dart';
import 'package:ulearning_app/core/usecases/t_usecase.dart';
import 'package:ulearning_app/features/course/domain/repository/course_repository.dart';

class GetCourseById implements TUsecase<Course, String> {
  const GetCourseById(this.courseRepository);
  final CourseRepository courseRepository;
  @override
  Future<Either<TFailure, Course>> call(String courseId) {
    return courseRepository.getCourseById(courseId);
  }
}
