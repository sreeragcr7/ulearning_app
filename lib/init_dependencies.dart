import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ulearning_app/core/common/cubit/app_user_cubit.dart';
import 'package:ulearning_app/core/network/internet_connection_check.dart';
import 'package:ulearning_app/core/utils/helpers/helper_function.dart';
import 'package:ulearning_app/core/utils/local_storage.dart';
import 'package:ulearning_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ulearning_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ulearning_app/features/auth/domain/repository/auth_repository.dart';
import 'package:ulearning_app/features/auth/domain/usecases/auth_state_changes.dart';
import 'package:ulearning_app/features/auth/domain/usecases/current_user.dart';
import 'package:ulearning_app/features/auth/domain/usecases/logout.dart';
import 'package:ulearning_app/features/auth/domain/usecases/user_login.dart';
import 'package:ulearning_app/features/auth/domain/usecases/user_signup.dart';
import 'package:ulearning_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ulearning_app/features/course/data/datasources/course_remote_data_source.dart';
import 'package:ulearning_app/features/course/data/repositories/course_repository_impl.dart';
import 'package:ulearning_app/features/course/domain/repository/course_repository.dart';
import 'package:ulearning_app/features/course/domain/usecases/get_course_by_id.dart';
import 'package:ulearning_app/features/course/domain/usecases/get_courses.dart';
import 'package:ulearning_app/features/course/domain/usecases/get_newest_courses.dart';
import 'package:ulearning_app/features/course/domain/usecases/get_popular_courses.dart';
import 'package:ulearning_app/features/navigation/presentation/bloc/nav_bloc.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  try {
    //Initializing hive
    await Hive.initFlutter();

    //Open Hive Box
    final box = await Hive.openBox('appBox');
    getIt.registerLazySingleton<Box>(() => box);

    //localstorage
    getIt.registerLazySingleton(() => LocalStorages(getIt<Box>()));
    //env variable
    await dotenv.load(fileName: '.env');

    //Initializing Supabase
    final supabaseUrl = dotenv.get('SUPABASE_URL');
    final supabaseAnonKey = dotenv.get('SUPABASE_ANON_KEY');
    final supabase = await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
    getIt.registerLazySingleton(() => supabase.client);

    //Internet connection
    getIt.registerLazySingleton(() => InternetConnection());
    getIt.registerLazySingleton<InternetConnectionCheck>(() => InternetConnectionCheckImpl(getIt()));
    getIt.registerLazySingleton(() => RepositoryHelper(getIt<InternetConnectionCheck>()));

    getIt.registerLazySingleton(() => AppUserCubit());

    //Initialize dependencies
    _initAuth();
    _initCourses();

    //Core dependencies
    getIt.registerFactory(() => NavBloc());
  } catch (e, stack) {
    print('initDependencies Error: $e');
    print(stack);
  }
}

void _initAuth() {
  getIt
    ..registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(supabaseClient: getIt<SupabaseClient>()))
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>(), getIt<InternetConnectionCheck>()),
    )
    ..registerFactory(() => UserLogin(getIt()))
    ..registerFactory(() => UserSignup(getIt()))
    ..registerFactory(() => CurrentUser(getIt()))
    ..registerFactory(() => Logout(getIt()))
    ..registerFactory(() => AuthStateChanges(getIt()))
    ..registerLazySingleton(
      () => AuthBloc(
        userLogin: getIt(),
        userSignup: getIt(),
        currentUser: getIt(),
        appUserCubit: getIt(),
        logout: getIt(),
        navBloc: getIt(),
        authStateChanges: getIt(),
      ),
    );
}

void _initCourses() {
  getIt
    ..registerFactory<CourseRemoteDataSource>(() => CourseRemoteDataSourceImpl(getIt<SupabaseClient>()))
    ..registerFactory<CourseRepository>(() => CourseRepositoryImpl(getIt<CourseRemoteDataSource>(), getIt()))
    ..registerFactory(() => GetCourses(getIt()))
    ..registerFactory(() => GetPopularCourses(getIt()))
    ..registerFactory(() => GetNewestCourses(getIt()))
    ..registerFactory(() => GetCourseById(getIt()));
}
