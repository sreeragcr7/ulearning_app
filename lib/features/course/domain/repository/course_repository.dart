import 'package:fpdart/fpdart.dart';
import 'package:ulearning_app/core/common/entities/course.dart';
import 'package:ulearning_app/core/error/failures.dart';

abstract interface class CourseRepository {
  Future<Either<TFailure, List<Course>>> getCourses();
  Future<Either<TFailure, List<Course>>> getPopularCourses();
  Future<Either<TFailure, List<Course>>> getNewestCourses();
  Future<Either<TFailure, Course>> getCourseById(String courseId);
}
