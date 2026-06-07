//  Now before proceding lets check everything out and i have doubt reguadding getCourse_details. check these code properly the rate it and changes if needed.
//  ,import 'package:equatable/equatable.dart';

// class Course extends Equatable {
//   const Course({
//     required this.id,
//     required this.title,
//     required this.subtitle,
//     required this.description,
//     required this.thumbnailUrl,
//     required this.instructorName,
//     required this.price,
//     required this.totalLessons,
//     required this.totalHours,
//     required this.studentsCount,
//     required this.rating,
//     required this.isPopular,
//     required this.categoryId,
//     required this.createdAt, required this.isPublished,
//   });

//   final String id;
//   final String title;
//   final String subtitle;
//   final String description;
//   final String thumbnailUrl;
//   final String instructorName;

//   final double price;
//   final int totalLessons;
//   final int totalHours;

//   final int studentsCount;
//   final double rating;

//   final bool isPopular;

//   final int? categoryId;

//   final DateTime createdAt;
//   final bool isPublished;

//   @override
//   List<Object?> get props => [
//     id,
//     title,
//     subtitle,
//     description,
//     thumbnailUrl,
//     instructorName,
//     price,
//     totalLessons,
//     totalHours,
//     studentsCount,
//     rating,
//     isPopular,
//     categoryId,
//     createdAt,
//   ];
// },  class Lesson {
//   Lesson({
//     required this.id,
//     required this.courseId,
//     required this.title,
//     required this.description,
//     required this.videoUrl,
//     required this.thumbnailUrl,
//     required this.durationMinutes,
//     required this.lessonOrder,
//     required this.isPreview,
//     required this.createdAt,
//   });

//   final String id;

//   final String courseId;

//   final String title;
//   final String description;

//   final String videoUrl;
//   final String? thumbnailUrl;

//   final int durationMinutes;

//   final int lessonOrder;

//   final bool isPreview;

//   final DateTime createdAt;
// }
// ,   import 'package:equatable/equatable.dart';

// class Section extends Equatable {
//   const Section({required this.id, required this.courseId, required this.title, required this.position});

//   final String id;
//   final String courseId;
//   final String title;
//   final int position;

//   @override
//   List<Object?> get props => [id, courseId, title, position];
// }
// ,  import 'package:fpdart/fpdart.dart';
// import 'package:ulearning_app/core/error/failures.dart';

// abstract interface class TUsecase<SuccessType, Params> {
//   Future<Either<TFailure, SuccessType>> call(Params params);
// }

// class NoParams {}
// ,  import 'package:flutter/material.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:ulearning_app/core/error/exceptions.dart';
// import 'package:ulearning_app/core/error/failures.dart';
// import 'package:ulearning_app/core/network/internet_connection_check.dart';
// import 'package:ulearning_app/core/utils/constants/topics.dart';

// class THelperFunction {
//   static bool isDarkMode(BuildContext context) {
//     return Theme.of(context).brightness == Brightness.dark;
//   }
// }

// class RepositoryHelper {
//   const RepositoryHelper(this.internetConnectionCheck);
//   final InternetConnectionCheck internetConnectionCheck;

//   Future<Either<TFailure, T>> execute<T>(Future<T> Function() fn) async {
//     try {
//       if (!await internetConnectionCheck.isConnected) {
//         return left(NetworkFailure(Constance.noConnectionErrorMessage));
//       }

//       final result = await fn();
//       return right(result);
//     } on AuthExceptions catch (e) {
//       return left(AuthFailure(e.message));
//     } on ServerExceptions catch (e) {
//       return left(ServerFailure(e.message));
//     } catch (e) {
//       return left(ServerFailure(e.toString()));
//     }
//   }
// }
// ,  abstract class TExceptions implements Exception {
//   const TExceptions(this.message);

//   final String message;
// }

// final class ServerExceptions extends TExceptions {
//   const ServerExceptions(super.message);
// }

// final class AuthExceptions extends TExceptions {
//   const AuthExceptions(super.message);
// }

// final class CacheExceptions extends TExceptions {
//   const CacheExceptions(super.message);
// },  abstract class TFailure {
//   const TFailure(this.message);

//   final String message;
// }

// final class ServerFailure extends TFailure {
//   const ServerFailure(super.message);
// }

// final class NetworkFailure extends TFailure {
//   const NetworkFailure(super.message);
// }

// final class AuthFailure extends TFailure {
//   const AuthFailure(super.message);
// }

// final class CacheFailure extends TFailure {
//   const CacheFailure(super.message);
// }
// ,  import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:ulearning_app/features/course/data/models/course_model.dart';
// // import 'package:ulearning_app/features/course/data/models/lesson_model.dart';

// abstract interface class CourseRemoteDataSource {
//   Future<List<CourseModel>> getAllCourses();
//   Future<List<CourseModel>> getPopularCourses();
//   Future<List<CourseModel>> getNewestCourses();
//   Future<CourseModel> getCourseById(String courseId);
//   // Future<List<LessonModel>> getLessons(String courseId);
// }

// class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
//   const CourseRemoteDataSourceImpl(this.supabase);
//   final SupabaseClient supabase;
//   @override
//   Future<List<CourseModel>> getAllCourses() async {
//     final response = await supabase.from('courses').select().eq('is_published', true);
//     return response.map<CourseModel>((e) => CourseModel.fromJson(e)).toList();
//   }

//   @override
//   Future<CourseModel> getCourseById(String courseId) async {
//     final response = await supabase.from('courses').select().eq('id', courseId).single();
//     return CourseModel.fromJson(response);
//   }

//   // @override
//   // Future<List<LessonModel>> getLessons(String courseId) async {
//   //   final response = await supabase
//   //       .from('sources')
//   //       .select()
//   //       .eq('course_id', courseId)
//   //       .order('lesson_order', ascending: true);

//   //   return response.map<LessonModel>((e) => LessonModel.fromJson(e)).toList();
//   // }

//   @override
//   Future<List<CourseModel>> getNewestCourses() async {
//     final response = await supabase
//         .from('courses')
//         .select()
//         .eq('is_published', true)
//         .order('created_at', ascending: false);

//     return response.map<CourseModel>((e) => CourseModel.fromJson(e)).toList();
//   }

//   @override
//   Future<List<CourseModel>> getPopularCourses() async {
//     final response = await supabase.from('courses').select().eq('is_published', true).eq('is_popular', true);
//     return response.map<CourseModel>((e) => CourseModel.fromJson(e)).toList();
//   }
// }
// ,  import 'package:ulearning_app/core/common/entities/course.dart';

// class CourseModel extends Course {
//   const CourseModel({
//     required super.id,
//     required super.title,
//     required super.subtitle,
//     required super.description,
//     required super.thumbnailUrl,
//     required super.instructorName,
//     required super.price,
//     required super.totalLessons,
//     required super.totalHours,
//     required super.studentsCount,
//     required super.rating,
//     required super.isPopular,
//     required super.categoryId,
//     required super.createdAt,
//     required super.isPublished,
//   });

//   factory CourseModel.fromJson(Map<String, dynamic> json) {
//     return CourseModel(
//       id: json['id'] ?? '',
//       categoryId: json['category_id'],
//       title: json['title'] ?? '',
//       subtitle: json['subtitle'] ?? '',
//       description: json['description'] ?? '',
//       thumbnailUrl: json['thumbnail_url'] ?? '',
//       instructorName: json['instructor_name'] ?? '',
//       price: (json['price'] as num?)?.toDouble() ?? 0.0,
//       totalLessons: json['total_lessons'] ?? 0,
//       totalHours: json['total_hours'] ?? 0,
//       studentsCount: json['students_count'] ?? 0,
//       rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
//       isPopular: json['is_popular'] ?? false,
//       createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
//       isPublished: json['is_published'] ?? false,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'category_id': categoryId,
//       'title': title,
//       'subtitle': subtitle,
//       'description': description,
//       'thumbnail_url': thumbnailUrl,
//       'instructor_name': instructorName,
//       'price': price,
//       'total_lessons': totalLessons,
//       'total_hours': totalHours,
//       'students_count': studentsCount,
//       'rating': rating,
//       'is_popular': isPopular,
//       'created_at': createdAt.toIso8601String(),
//       'is_published': isPublished,
//     };
//   }

//   CourseModel copyWith({
//     String? id,
//     int? categoryId,
//     String? title,
//     String? subtitle,
//     String? description,
//     String? thumbnailUrl,
//     String? instructorName,
//     double? price,
//     int? totalLessons,
//     int? totalHours,
//     int? studentsCount,
//     double? rating,
//     bool? isPopular,
//     DateTime? createdAt,
//     bool? isPublished,
//   }) {
//     return CourseModel(
//       id: id ?? this.id,
//       categoryId: categoryId ?? this.categoryId,
//       title: title ?? this.title,
//       subtitle: subtitle ?? this.subtitle,
//       description: description ?? this.description,
//       thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
//       instructorName: instructorName ?? this.instructorName,
//       price: price ?? this.price,
//       totalLessons: totalLessons ?? this.totalLessons,
//       totalHours: totalHours ?? this.totalHours,
//       studentsCount: studentsCount ?? this.studentsCount,
//       rating: rating ?? this.rating,
//       isPopular: isPopular ?? this.isPopular,
//       createdAt: createdAt ?? this.createdAt,
//       isPublished: isPublished ?? this.isPublished,
//     );
//   }
// }
// ,   import 'package:ulearning_app/core/common/entities/entities.dart';

// class LessonModel extends Lesson {
//   LessonModel({
//     required super.id,
//     required super.courseId,
//     required super.title,
//     required super.description,
//     required super.videoUrl,
//     required super.thumbnailUrl,
//     required super.durationMinutes,
//     required super.lessonOrder,
//     required super.isPreview,
//     required super.createdAt,
//   });

//   factory LessonModel.fromJson(Map<String, dynamic> json) {
//     return LessonModel(
//       id: json['id'] ?? '',

//       courseId: json['course_id'] ?? '',

//       title: json['title'] ?? '',

//       description: json['description'] ?? '',

//       videoUrl: json['video_url'] ?? '',

//       thumbnailUrl: json['thumbnail_url'] ?? '',

//       durationMinutes: json['duration_minutes'] ?? 0,

//       lessonOrder: json['lesson_order'] ?? 0,

//       isPreview: json['is_preview'] ?? false,
//       createdAt: DateTime.parse(json['created_at']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'course_id': courseId,
//       'title': title,
//       'description': description,
//       'video_url': videoUrl,
//       'thumbnail_url': thumbnailUrl,
//       'duration_minutes': durationMinutes,
//       'lesson_order': lessonOrder,
//       'is_preview': isPreview,
//       'created_at': createdAt.toIso8601String(),
//     };
//   }

//   LessonModel copyWith({
//     String? id,
//     String? courseId,
//     String? title,
//     String? description,
//     String? videoUrl,
//     String? thumbnailUrl,
//     int? durationMinutes,
//     int? lessonOrder,
//     bool? isPreview,
//     DateTime? createdAt,
//   }) {
//     return LessonModel(
//       id: id ?? this.id,
//       courseId: courseId ?? this.courseId,
//       title: title ?? this.title,
//       description: description ?? this.description,
//       videoUrl: videoUrl ?? this.videoUrl,
//       thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
//       durationMinutes: durationMinutes ?? this.durationMinutes,
//       lessonOrder: lessonOrder ?? this.lessonOrder,
//       isPreview: isPreview ?? this.isPreview,
//       createdAt: createdAt ?? this.createdAt,
//     );
//   }
// }
// ,  import 'package:ulearning_app/core/common/entities/section.dart';

// class SectionModel extends Section {
//   const SectionModel({required super.id, required super.courseId, required super.title, required super.position});

//   factory SectionModel.fromJson(Map<String, dynamic> json) {
//     return SectionModel(
//       id: json['id'] as String,
//       courseId: json['course_id'] as String,
//       title: json['title'] as String,
//       position: json['position'] as int,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {'id': id, 'course_id': courseId, 'title': title, 'position': position};
//   }
// }
// ,  import 'package:fpdart/fpdart.dart';
// import 'package:ulearning_app/core/common/entities/course.dart';
// import 'package:ulearning_app/core/error/failures.dart';
// import 'package:ulearning_app/core/utils/helpers/helper_function.dart';
// import 'package:ulearning_app/features/course/data/datasources/course_remote_data_source.dart';
// import 'package:ulearning_app/features/course/domain/repository/course_repository.dart';

// class CourseRepositoryImpl implements CourseRepository {
//   const CourseRepositoryImpl(this.remoteDataSource, this.repositoryHelper);
//   final CourseRemoteDataSource remoteDataSource;
//   final RepositoryHelper repositoryHelper;

//   @override
//   Future<Either<TFailure, List<Course>>> getCourses() async {
//     return repositoryHelper.execute(() => remoteDataSource.getAllCourses());
//   }

//   @override
//   Future<Either<TFailure, Course>> getCourseById(String courseId) async {
//     return repositoryHelper.execute(() => remoteDataSource.getCourseById(courseId));
//   }

//   @override
//   Future<Either<TFailure, List<Course>>> getNewestCourses() async {
//     return repositoryHelper.execute(() => remoteDataSource.getNewestCourses());
//   }

//   @override
//   Future<Either<TFailure, List<Course>>> getPopularCourses() async {
//     return repositoryHelper.execute(() => remoteDataSource.getPopularCourses());
//   }
// }
// ,  import 'package:fpdart/fpdart.dart';
// import 'package:ulearning_app/core/common/entities/course.dart';
// import 'package:ulearning_app/core/error/failures.dart';

// abstract interface class CourseRepository {
//   Future<Either<TFailure, List<Course>>> getCourses();
//   Future<Either<TFailure, List<Course>>> getPopularCourses();
//   Future<Either<TFailure, List<Course>>> getNewestCourses();
//   Future<Either<TFailure, Course>> getCourseById(String courseId);
// }
// ,  import 'package:fpdart/fpdart.dart';
// import 'package:ulearning_app/core/common/entities/course.dart';
// import 'package:ulearning_app/core/error/failures.dart';
// import 'package:ulearning_app/core/usecases/t_usecase.dart';
// import 'package:ulearning_app/features/course/domain/repository/course_repository.dart';

// class GetCourseById implements TUsecase<Course, String> {
//   const GetCourseById(this.courseRepository);
//   final CourseRepository courseRepository;
//   @override
//   Future<Either<TFailure, Course>> call(String courseId) {
//     return courseRepository.getCourseById(courseId);
//   }
// }
// ,  import 'package:fpdart/fpdart.dart';
// import 'package:ulearning_app/core/common/entities/course.dart';
// import 'package:ulearning_app/core/error/failures.dart';
// import 'package:ulearning_app/core/usecases/t_usecase.dart';
// import 'package:ulearning_app/features/course/domain/repository/course_repository.dart';

// class GetCourses implements TUsecase<List<Course>, NoParams> {
//   const GetCourses(this.courseRepository);
//   final CourseRepository courseRepository;
//   @override
//   Future<Either<TFailure, List<Course>>> call(NoParams params) {
//     return courseRepository.getCourses();
//   }
// }
// ,  import 'package:fpdart/fpdart.dart';
// import 'package:ulearning_app/core/common/entities/course.dart';
// import 'package:ulearning_app/core/error/failures.dart';
// import 'package:ulearning_app/core/usecases/t_usecase.dart';
// import 'package:ulearning_app/features/course/domain/repository/course_repository.dart';

// class GetNewestCourses implements TUsecase<List<Course>, NoParams> {
//   const GetNewestCourses(this.courseRepository);
//   final CourseRepository courseRepository;
//   @override
//   Future<Either<TFailure, List<Course>>> call(NoParams params) {
//     return courseRepository.getNewestCourses();
//   }
// }
// ,  import 'package:fpdart/fpdart.dart';
// import 'package:ulearning_app/core/common/entities/course.dart';
// import 'package:ulearning_app/core/error/failures.dart';
// import 'package:ulearning_app/core/usecases/t_usecase.dart';
// import 'package:ulearning_app/features/course/domain/repository/course_repository.dart';

// class GetPopularCourses implements TUsecase<List<Course>, NoParams> {
//   const GetPopularCourses(this.courseRepository);
//   final CourseRepository courseRepository;
//   @override
//   Future<Either<TFailure, List<Course>>> call(NoParams params) {
//     return courseRepository.getPopularCourses();
//   }
// }
// ,  import 'package:fpdart/fpdart.dart';
// import 'package:ulearning_app/copy.dart';

// class GetCourseDetails implements TUsecase{
//   @override
//   Future<Either<TFailure, dynamic>> call(params) {
//     // TODO: implement call
//     throw UnimplementedError();
//   }
// },  part of 'course_bloc.dart';

// @immutable
// sealed class CourseEvent {}

// final class LoadCourses extends CourseEvent {}

// final class LoadPopularCourses extends CourseEvent {}

// final class LoadNewestCourses extends CourseEvent {}

// final class LoadCourseDetails extends CourseEvent {}
// ,  part of 'course_bloc.dart';

// @immutable
// sealed class CourseState {}

// final class CourseInitial extends CourseState {}

// final class CourseLoading extends CourseState {}

// final class CourseLoaded extends CourseState {}

// final class CourseDetailsLoaded extends CourseState {}

// final class CourseFailure extends CourseState {}
// ,   import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:ulearning_app/core/common/cubit/app_user_cubit.dart';
// import 'package:ulearning_app/core/network/internet_connection_check.dart';
// import 'package:ulearning_app/core/utils/helpers/helper_function.dart';
// import 'package:ulearning_app/core/utils/local_storage.dart';
// import 'package:ulearning_app/features/auth/data/datasources/auth_remote_data_source.dart';
// import 'package:ulearning_app/features/auth/data/repositories/auth_repository_impl.dart';
// import 'package:ulearning_app/features/auth/domain/repository/auth_repository.dart';
// import 'package:ulearning_app/features/auth/domain/usecases/auth_state_changes.dart';
// import 'package:ulearning_app/features/auth/domain/usecases/current_user.dart';
// import 'package:ulearning_app/features/auth/domain/usecases/logout.dart';
// import 'package:ulearning_app/features/auth/domain/usecases/user_login.dart';
// import 'package:ulearning_app/features/auth/domain/usecases/user_signup.dart';
// import 'package:ulearning_app/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:ulearning_app/features/course/data/datasources/course_remote_data_source.dart';
// import 'package:ulearning_app/features/course/data/repositories/course_repository_impl.dart';
// import 'package:ulearning_app/features/course/domain/repository/course_repository.dart';
// import 'package:ulearning_app/features/course/domain/usecases/get_course_by_id.dart';
// import 'package:ulearning_app/features/course/domain/usecases/get_courses.dart';
// import 'package:ulearning_app/features/course/domain/usecases/get_newest_courses.dart';
// import 'package:ulearning_app/features/course/domain/usecases/get_popular_courses.dart';
// import 'package:ulearning_app/features/navigation/presentation/bloc/nav_bloc.dart';

// final getIt = GetIt.instance;

// Future<void> initDependencies() async {
//   try {
//     //Initializing hive
//     await Hive.initFlutter();

//     //Open Hive Box
//     final box = await Hive.openBox('appBox');
//     getIt.registerLazySingleton<Box>(() => box);

//     //localstorage
//     getIt.registerLazySingleton(() => LocalStorages(getIt<Box>()));
//     //env variable
//     await dotenv.load(fileName: '.env');

//     //Initializing Supabase
//     final supabaseUrl = dotenv.get('SUPABASE_URL');
//     final supabaseAnonKey = dotenv.get('SUPABASE_ANON_KEY');
//     final supabase = await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
//     getIt.registerLazySingleton(() => supabase.client);

//     //Internet connection
//     getIt.registerLazySingleton(() => InternetConnection());
//     getIt.registerLazySingleton<InternetConnectionCheck>(() => InternetConnectionCheckImpl(getIt()));
//     getIt.registerLazySingleton(() => RepositoryHelper(getIt<InternetConnectionCheck>()));

//     getIt.registerLazySingleton(() => AppUserCubit());

//     //Initialize dependencies
//     _initAuth();
//     _initCourses();

//     //Core dependencies
//     getIt.registerFactory(() => NavBloc());
//   } catch (e, stack) {
//     print('initDependencies Error: $e');
//     print(stack);
//   }
// }

// void _initAuth() {
//   getIt
//     ..registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(supabaseClient: getIt<SupabaseClient>()))
//     ..registerFactory<AuthRepository>(
//       () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>(), getIt<InternetConnectionCheck>()),
//     )
//     ..registerFactory(() => UserLogin(getIt()))
//     ..registerFactory(() => UserSignup(getIt()))
//     ..registerFactory(() => CurrentUser(getIt()))
//     ..registerFactory(() => Logout(getIt()))
//     ..registerFactory(() => AuthStateChanges(getIt()))
//     ..registerLazySingleton(
//       () => AuthBloc(
//         userLogin: getIt(),
//         userSignup: getIt(),
//         currentUser: getIt(),
//         appUserCubit: getIt(),
//         logout: getIt(),
//         navBloc: getIt(),
//         authStateChanges: getIt(),
//       ),
//     );
// }

// void _initCourses() {
//   getIt
//     ..registerFactory<CourseRemoteDataSource>(() => CourseRemoteDataSourceImpl(getIt<SupabaseClient>()))
//     ..registerFactory<CourseRepository>(() => CourseRepositoryImpl(getIt<CourseRemoteDataSource>(), getIt()))
//     ..registerFactory(() => GetCourses(getIt()))
//     ..registerFactory(() => GetPopularCourses(getIt()))
//     ..registerFactory(() => GetNewestCourses(getIt()))
//     ..registerFactory(() => GetCourseById(getIt()));
// }
// , 
