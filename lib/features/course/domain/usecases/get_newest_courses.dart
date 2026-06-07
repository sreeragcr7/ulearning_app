import 'package:fpdart/fpdart.dart';
import 'package:ulearning_app/core/common/entities/course.dart';
import 'package:ulearning_app/core/error/failures.dart';
import 'package:ulearning_app/core/usecases/t_usecase.dart';
import 'package:ulearning_app/features/course/domain/repository/course_repository.dart';

class GetNewestCourses implements TUsecase<List<Course>, NoParams> {
  const GetNewestCourses(this.courseRepository);
  final CourseRepository courseRepository;
  @override
  Future<Either<TFailure, List<Course>>> call(NoParams params) {
    return courseRepository.getNewestCourses();
  }
}
