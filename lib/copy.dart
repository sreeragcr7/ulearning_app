// import 'package:flutter/material.dart';

// import 'package:flutter/services.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:ulearning_app/app_entry_point.dart';

// import 'package:ulearning_app/core/common/cubit/app_user_cubit.dart';

// import 'package:ulearning_app/core/routes/app_router.dart';

// import 'package:ulearning_app/core/theme/app_theme.dart';

// import 'package:ulearning_app/features/auth/presentation/bloc/auth_bloc.dart';

// import 'package:ulearning_app/features/course/presentation/bloc/course_bloc.dart';

// import 'package:ulearning_app/features/navigation/presentation/bloc/nav_bloc.dart';

// import 'package:ulearning_app/features/onboarding/cubit/on_boarding_cubit.dart';

// import 'package:ulearning_app/init_dependencies.dart';



// void main() async {

//   WidgetsFlutterBinding.ensureInitialized();

//   await initDependencies();

//   SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

//   runApp(

//     MultiBlocProvider(

//       providers: [

//         BlocProvider(create: (_) => getIt<AppUserCubit>()),

//         BlocProvider(create: (_) => OnBoardingCubit()),

//         BlocProvider(create: (_) => getIt<AuthBloc>()),

//         BlocProvider(create: (_) => getIt<NavBloc>()),

//         BlocProvider(create: (_) => getIt<CourseBloc>()),

//       ],

//       child: ScreenUtilInit(

//         designSize: const Size(375, 812),

//         minTextAdapt: true,

//         splitScreenMode: true,

//         child: const MyApp(),

//       ),

//     ),

//   );

// }



// class MyApp extends StatefulWidget {

//   const MyApp({super.key});



//   @override

//   State<MyApp> createState() => _MyAppState();

// }



// class _MyAppState extends State<MyApp> {

//   @override

//   void initState() {

//     super.initState();



//     WidgetsBinding.instance.addPostFrameCallback((_) {

//       context.read<AuthBloc>().add(CheckSessionEvent());

//     });

//   }



//   @override

//   Widget build(BuildContext context) {

//     return MaterialApp(

//       debugShowCheckedModeBanner: false,

//       onGenerateRoute: AppRouter.onGenerateRoute,

//       // initialRoute: AppRoutes.onboarding,

//       title: 'Flutter Demo',

//       theme: AppTheme.lightTheme,

//       darkTheme: AppTheme.darkTheme,

//       themeMode: ThemeMode.system,

//       home: const AppEntryPoint(),

//     );

//   }

// } ,    import 'package:flutter_dotenv/flutter_dotenv.dart';

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

// import 'package:ulearning_app/features/course/presentation/bloc/course_bloc.dart';

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

//     ..registerFactory(() => GetCourseById(getIt()))

//     ..registerFactory(() => CourseBloc(getCourses: getIt()));

// } ,   import 'package:supabase_flutter/supabase_flutter.dart';

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

//     final response = await supabase

//         .from('courses')

//         .select()

//         .eq('is_published', true)

//         .order('created_at', ascending: false);

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

// } ,   import 'package:ulearning_app/core/common/entities/course.dart';



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

//       createdAt: DateTime.parse(json['created_at']),

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

// } ,  import 'package:ulearning_app/core/common/entities/entities.dart';



// class LessonModel extends Lesson {

//   const LessonModel({

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



//       thumbnailUrl: json['thumbnail_url'],



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

// },  import 'package:ulearning_app/core/common/entities/section.dart';

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
// ,   import 'package:fpdart/fpdart.dart';
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
// ,   import 'package:fpdart/fpdart.dart';
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
// ,   import 'package:fpdart/fpdart.dart';
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
// ,   import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ulearning_app/core/common/entities/course.dart';
// import 'package:ulearning_app/core/usecases/t_usecase.dart';
// import 'package:ulearning_app/features/course/domain/usecases/get_courses.dart';

// part 'course_event.dart';
// part 'course_state.dart';

// class CourseBloc extends Bloc<CourseEvent, CourseState> {
//   CourseBloc({required GetCourses getCourses}) : _getCourses = getCourses, super(CourseInitial()) {
//     on<LoadCourses>(_onLoadCourses);
//   }

//   final GetCourses _getCourses;

//   Future<void> _onLoadCourses(LoadCourses event, Emitter<CourseState> emit) async {
//     emit(CourseLoading());

//     final result = await _getCourses(NoParams());
//     result.fold((failure) => emit(CourseFailure(failure.message)), (courses) => emit(CourseLoaded(courses)));
//   }
// }
// ,  part of 'course_bloc.dart';

// @immutable
// sealed class CourseEvent {}

// final class LoadCourses extends CourseEvent {}

// // final class LoadPopularCourses extends CourseEvent {}

// // final class LoadNewestCourses extends CourseEvent {}

// // final class LoadCourseDetails extends CourseEvent {}
// ,  part of 'course_bloc.dart';

// @immutable
// sealed class CourseState {
//   const CourseState();
// }

// final class CourseInitial extends CourseState {}

// final class CourseLoading extends CourseState {}

// final class CourseLoaded extends CourseState {
//   const CourseLoaded(this.courses);
//   final List<Course> courses;
// }

// final class CourseFailure extends CourseState {
//   const CourseFailure(this.message);
//   final String message;
// }

// // final class CourseDetailsLoaded extends CourseState {
// //   const CourseDetailsLoaded(this.course);
// //   final Course course;
// // }

// ,  import 'package:flutter/material.dart';
// import 'package:ulearning_app/core/common/widgets/banner_carousel.dart';
// import 'package:ulearning_app/core/common/widgets/gradient/gradient_list_view.dart';
// import 'package:ulearning_app/core/common/widgets/search/search_filter.dart';
// import 'package:ulearning_app/core/common/widgets/section_header.dart';
// import 'package:ulearning_app/core/common/widgets/t_app_bar.dart';
// import 'package:ulearning_app/core/utils/constants/sizes.dart';
// import 'package:ulearning_app/features/course/presentation/widgets/course_list_items.dart';

// class CoursePage extends StatefulWidget {
//   const CoursePage({super.key});

//   @override
//   State<CoursePage> createState() => _CoursePageState();
// }

// class _CoursePageState extends State<CoursePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: TAppBar(title: 'Your Courses', icon: Icons.shopping_cart_outlined),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: TSizes.screenPadding, vertical: TSizes.screenTop),
//               child: Column(
//                 children: [
//                   BannerCarousel(),
//                   SizedBox(height: TSizes.btwSection - 10),
//                   SearchFilter(),
//                   SizedBox(height: TSizes.btwSection - 10),
//                   SectionHeader(title: 'All Courses', onSeeAll: () {}),
//                 ],
//               ),
//             ),
//             GradientListView(items: yourCourseItems, shrinkWrap: true, physics: NeverScrollableScrollPhysics()),
//           ],
//         ),
//       ),
//     );
//   }
// }
// ,  import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:ulearning_app/core/common/widgets/common_button.dart';
// import 'package:ulearning_app/core/common/widgets/gradient/gradient_icon_box.dart';
// import 'package:ulearning_app/core/common/widgets/gradient/gradient_image_box.dart';
// import 'package:ulearning_app/core/common/widgets/gradient/gradient_list.dart';
// import 'package:ulearning_app/core/common/widgets/icon_count.dart';
// import 'package:ulearning_app/core/common/widgets/t_app_bar.dart';
// import 'package:ulearning_app/core/utils/constants/sizes.dart';
// import 'package:ulearning_app/features/course/presentation/widgets/course_list_items.dart';
// import 'package:ulearning_app/core/common/widgets/section_header.dart';

// class CourseDetailsPage extends StatelessWidget {
//   const CourseDetailsPage({super.key, required this.title, required this.subTitle, required this.imageUrl});

//   final String title;
//   final String subTitle;
//   final String imageUrl;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: TAppBar(title: 'Course details'),
//       body: SafeArea(
//         top: false,
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,

//             children: [
//               /// PADDED CONTENT
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: TSizes.screenPadding),

//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 10),

//                     /// IMAGE
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(20),
//                       child: Image.network(imageUrl, width: double.infinity, height: 200, fit: BoxFit.cover),
//                     ),

//                     SizedBox(height: TSizes.btwItems - 2),

//                     /// TOP ROW
//                     Row(
//                       children: [
//                         ActionChip(
//                           side: BorderSide.none,
//                           backgroundColor: Colors.deepPurple,

//                           label: const Text(
//                             'Author Page',
//                             style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//                           ),

//                           onPressed: () {},

//                           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),

//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                         ),

//                         const SizedBox(width: 30),

//                         const IconCount(icon: Icons.people, count: '0', size: 24, fontSize: 15),

//                         const SizedBox(width: 30),

//                         const IconCount(icon: Iconsax.star1, count: '5', size: 24, fontSize: 15),
//                       ],
//                     ),

//                     SizedBox(height: TSizes.btwItems - 5),

//                     const SectionHeader(title: 'Course Description'),

//                     SizedBox(height: TSizes.btwItems - 5),

//                     Text(description, style: TextStyle(color: Colors.grey)),

//                     SizedBox(height: TSizes.btwSection),

//                     CommonBtn(btn: 'Go Buy', onPressed: () {}),

//                     SizedBox(height: TSizes.btwSection),

//                     const SectionHeader(title: 'This Course Includes', fontSize: 15),

//                     SizedBox(height: TSizes.btwItems - 10),
//                   ],
//                 ),
//               ),

//               //Abot info
//               GradientList(
//                 leading: GradientIconBox(icon: Icons.videocam),
//                 title: '36 Houres Video',
//                 // iconSize: 20,
//                 // height: 30,
//                 // width: 30,
//                 titleSize: 14,
//               ),
//               GradientList(
//                 leading: GradientIconBox(icon: Iconsax.book),
//                 title: 'Total 36 Lessons',
//                 // iconSize: 20,
//                 // height: 30,
//                 // width: 30,
//                 titleSize: 14,
//               ),
//               GradientList(
//                 leading: GradientIconBox(icon: Icons.cloud),
//                 title: '67 Downloaded resources',
//                 // iconSize: 20,
//                 // height: 30,
//                 // width: 30,
//                 titleSize: 14,
//               ),

//               SizedBox(height: TSizes.btwItems - 10),

//               /// LESSON LIST HEADER
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: TSizes.screenPadding),

//                 child: const SectionHeader(title: 'Lesson List'),
//               ),

//               SizedBox(height: TSizes.btwItems - 10),

//               GradientList(
//                 title: 'UI Design',
//                 subTitle: 'UI Design',
//                 leading: GradientImageBox(imageUrl: imageUrl),

//                 onTap: () {},
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// ,  