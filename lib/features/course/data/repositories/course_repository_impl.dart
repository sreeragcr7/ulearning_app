import 'package:fpdart/fpdart.dart';
import 'package:ulearning_app/core/common/entities/course.dart';
import 'package:ulearning_app/core/error/failures.dart';
import 'package:ulearning_app/core/utils/helpers/helper_function.dart';
import 'package:ulearning_app/features/course/data/datasources/course_remote_data_source.dart';
import 'package:ulearning_app/features/course/domain/repository/course_repository.dart';

class CourseRepositoryImpl implements CourseRepository {
  const CourseRepositoryImpl(this.remoteDataSource, this.repositoryHelper);
  final CourseRemoteDataSource remoteDataSource;
  final RepositoryHelper repositoryHelper;

  @override
  Future<Either<TFailure, List<Course>>> getCourses() async {
    return repositoryHelper.execute(() => remoteDataSource.getAllCourses());
  }

  @override
  Future<Either<TFailure, Course>> getCourseById(String courseId) async {
    return repositoryHelper.execute(() => remoteDataSource.getCourseById(courseId));
  }

  @override
  Future<Either<TFailure, List<Course>>> getNewestCourses() async {
    return repositoryHelper.execute(() => remoteDataSource.getNewestCourses());
  }

  @override
  Future<Either<TFailure, List<Course>>> getPopularCourses() async {
    return repositoryHelper.execute(() => remoteDataSource.getPopularCourses());
  }
}
