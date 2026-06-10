import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/core/common/cubit/app_user_cubit.dart';
import 'package:ulearning_app/core/common/widgets/loader.dart';
import 'package:ulearning_app/core/common/widgets/t_app_bar.dart';
import 'package:ulearning_app/core/utils/constants/enums.dart';
import 'package:ulearning_app/core/utils/constants/sizes.dart';
import 'package:ulearning_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ulearning_app/features/auth/presentation/pages/login_page.dart';
import 'package:ulearning_app/core/common/widgets/banner_carousel.dart';
import 'package:ulearning_app/features/banner/presentation/bloc/banner_bloc.dart';
import 'package:ulearning_app/features/course/presentation/bloc/course_bloc.dart';
import 'package:ulearning_app/features/course/presentation/bloc/course_state.dart';
import 'package:ulearning_app/features/home/presentation/widgets/category_selector.dart';
import 'package:ulearning_app/features/course/presentation/widgets/course_grid.dart';
import 'package:ulearning_app/features/home/presentation/widgets/greeting_text.dart';
import 'package:ulearning_app/features/home/presentation/widgets/home_drawer.dart';
import 'package:ulearning_app/core/common/widgets/search/search_filter.dart';
import 'package:ulearning_app/core/common/widgets/section_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    context.read<CourseBloc>().add(LoadCourses());
    context.read<BannerBloc>().add(LoadBanners());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is AuthLoggedOut) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginPage()), (route) => false);
        }
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        drawer: HomeDrawer(
          onLogout: () {
            context.read<AuthBloc>().add(LogoutEvent());
          },
        ),
        appBar: TAppBar(icon: Icons.person, showAvatar: true),
        body: BlocBuilder<AppUserCubit, AppUserState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }

            if (state is AppUserAuthenticated) {
              final user = state.user;

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: TSizes.screenPadding - 10, vertical: TSizes.screenTop),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GreetingText(userName: user.username),
                      const SizedBox(height: 12),
                      SearchFilter(),
                      const SizedBox(height: 20),
                      BannerCarousel(),
                      const SizedBox(height: 12),
                      SectionHeader(onSeeAll: () {}, title: 'Choose your course'),
                      const SizedBox(height: 12),
                      CategorySelector(),
                      const SizedBox(height: 20),
                      BlocBuilder<CourseBloc, CourseState>(
                        builder: (context, state) {
                          if (state.status == RequestStatus.loading) {
                            return const Loader();
                          }

                          if (state.status == RequestStatus.failure) {
                            return Text(state.errorMessage ?? 'Something went wrong');
                          }
                          return CourseGrid(courses: state.filteredCourses);
                        },
                      ),
                    ],
                  ),
                ),
              );
            }

            return const Center(child: Text('No user Logged In'));
          },
        ),
      ),
    );
  }
}
