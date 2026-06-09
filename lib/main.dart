import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/app_entry_point.dart';
import 'package:ulearning_app/core/common/cubit/app_user_cubit.dart';
import 'package:ulearning_app/core/routes/app_router.dart';
import 'package:ulearning_app/core/theme/app_theme.dart';
import 'package:ulearning_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ulearning_app/features/banner/presentation/bloc/banner_bloc.dart';
import 'package:ulearning_app/features/course/presentation/bloc/course_bloc.dart';
import 'package:ulearning_app/features/navigation/presentation/bloc/nav_bloc.dart';
import 'package:ulearning_app/features/onboarding/cubit/on_boarding_cubit.dart';
import 'package:ulearning_app/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AppUserCubit>()),
        BlocProvider(create: (_) => OnBoardingCubit()),
        BlocProvider(create: (_) => getIt<AuthBloc>()),
        BlocProvider(create: (_) => getIt<NavBloc>()),
        BlocProvider(create: (_) => getIt<CourseBloc>()),
        BlocProvider(create: (_) => getIt<BannerBloc>())
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(CheckSessionEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute,
      // initialRoute: AppRoutes.onboarding,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const AppEntryPoint(),
    );
  }
}
