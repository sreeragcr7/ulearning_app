import 'package:flutter/material.dart';
import 'package:ulearning_app/core/routes/app_routes.dart';
import 'package:ulearning_app/features/auth/presentation/pages/login_page.dart';
import 'package:ulearning_app/features/auth/presentation/pages/signup_page.dart';
import 'package:ulearning_app/features/auth/presentation/widgets/route_trans.dart';
import 'package:ulearning_app/features/course/presentation/pages/course_details.dart';
import 'package:ulearning_app/features/navigation/presentation/pages/main_page.dart';
import 'package:ulearning_app/features/onboarding/pages/welcome.dart';
import 'package:ulearning_app/features/settings/presentation/pages/settings_page.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const Welcome());
      case AppRoutes.login:
        return slideRoute(const LoginPage());
      case AppRoutes.signup:
        return slideRoute(const SignupPage());
      case AppRoutes.main:
        return MaterialPageRoute(builder: (_) => const MainPage());
      case AppRoutes.courseDetails:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) =>
              CourseDetailsPage(title: args['title'], subTitle: args['subTitle'], imageUrl: args['imageUrl']),
        );
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
