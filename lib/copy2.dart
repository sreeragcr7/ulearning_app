// import 'package:equatable/equatable.dart';

// class Section extends Equatable {
//   const Section({required this.id, required this.courseId, required this.title, required this.position});

//   final String id;
//   final String courseId;
//   final String title;
//   final int position;

//   @override
//   List<Object?> get props => [id, courseId, title, position];
// }
// ,  import 'package:equatable/equatable.dart';

// class Lesson extends Equatable {
//   const Lesson({
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

//   @override
//   List<Object?> get props => [
//     id,
//     courseId,
//     title,
//     description,
//     videoUrl,
//     thumbnailUrl,
//     durationMinutes,
//     lessonOrder,
//     isPreview,
//     createdAt,
//   ];
// }
// ,  import 'package:equatable/equatable.dart';

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
//     isPublished
//   ];
// }
// ,  import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ulearning_app/core/common/cubit/app_user_cubit.dart';
// import 'package:ulearning_app/core/common/widgets/loader.dart';
// import 'package:ulearning_app/core/common/widgets/t_app_bar.dart';
// import 'package:ulearning_app/core/utils/constants/sizes.dart';
// import 'package:ulearning_app/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:ulearning_app/features/auth/presentation/pages/login_page.dart';
// import 'package:ulearning_app/core/common/widgets/banner_carousel.dart';
// import 'package:ulearning_app/features/home/presentation/widgets/category_selector.dart';
// import 'package:ulearning_app/features/course/presentation/widgets/course_grid.dart';
// import 'package:ulearning_app/features/home/presentation/widgets/greeting_text.dart';
// import 'package:ulearning_app/features/home/presentation/widgets/home_drawer.dart';
// import 'package:ulearning_app/core/common/widgets/search/search_filter.dart';
// import 'package:ulearning_app/core/common/widgets/section_header.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthBloc, AuthBlocState>(
//       listener: (context, state) {
//         if (state is AuthLoggedOut) {
//           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginPage()), (route) => false);
//         }
//       },
//       child: Scaffold(
//         extendBody: true,
//         backgroundColor: Theme.of(context).colorScheme.surface,
//         drawer: HomeDrawer(
//           onLogout: () {
//             context.read<AuthBloc>().add(LogoutEvent());
//           },
//         ),
//         appBar: TAppBar(icon: Icons.person, showAvatar: true),
//         body: BlocBuilder<AppUserCubit, AppUserState>(
//           builder: (context, state) {
//             if (state is AuthLoading) {
//               return const Loader();
//             }

//             if (state is AppUserAuthenticated) {
//               final user = state.user;

//               return SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: TSizes.screenPadding, vertical: TSizes.screenTop),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       GreetingText(userName: user.username),
//                       const SizedBox(height: 12),
//                       SearchFilter(),
//                       const SizedBox(height: 20),
//                       BannerCarousel(),
//                       const SizedBox(height: 12),
//                       SectionHeader(onSeeAll: () {}, title: 'Choose your course'),
//                       const SizedBox(height: 12),
//                       CategorySelector(),
//                       const SizedBox(height: 20),
//                       CourseGrid(),
//                     ],
//                   ),
//                 ),
//               );
//             }

//             return const Center(child: Text('No user Logged In'));
//           },
//         ),
//       ),
//     );
//   }
// }
// ,  import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// part 'home_event.dart';
// part 'home_state.dart';

// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   HomeBloc() : super(HomeInitial()) {
//     on<HomeEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }
// ,  import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:ulearning_app/features/course/presentation/pages/course_page.dart';
// import 'package:ulearning_app/features/home/presentation/pages/home_page.dart';
// import 'package:ulearning_app/features/navigation/presentation/bloc/nav_bloc.dart';
// import 'package:ulearning_app/features/profile/presentation/pages/profile_page.dart';
// import 'package:ulearning_app/features/search/presentation/pages/search_page.dart';

// class MainPage extends StatelessWidget {
//   const MainPage({super.key});

//   static const List<Widget> _pages = [
//     HomePage(),
//     SearchPage(),
//     CoursePage(),
//     Center(child: Text("Chat Page")),
//     ProfilePage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<NavBloc, NavState>(
//       builder: (context, state) {
//         return Scaffold(
//           extendBody: true,
//           extendBodyBehindAppBar: true,

//           body: IndexedStack(index: state.index, children: _pages),
//           bottomNavigationBar: Container(
//             decoration: BoxDecoration(
//               border: Border(top: BorderSide(color: Theme.of(context).dividerColor.withAlpha(38), width: 1)),
//             ),
//             child: Material(
//               shadowColor: Colors.transparent, // 👈 remove tonal shadow
//               child: NavigationBar(
//                 backgroundColor: Theme.of(context).colorScheme.surface,
//                 surfaceTintColor: Colors.transparent, // 👈 VERY IMPORTANT
//                 shadowColor: Colors.transparent, // 👈 remove tonal shadow
//                 height: 65,
//                 elevation: 0,
//                 labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
//                 selectedIndex: state.index,
//                 onDestinationSelected: (index) {
//                   context.read<NavBloc>().add(NavTabChangedEvent(index));
//                 },
//                 destinations: const [
//                   NavigationDestination(icon: Icon(Iconsax.home_1), selectedIcon: Icon(Iconsax.home5), label: 'Home'),
//                   NavigationDestination(
//                     icon: Icon(Icons.search),
//                     selectedIcon: Icon(Iconsax.search_normal),
//                     label: 'Search',
//                   ),
//                   NavigationDestination(icon: Icon(Iconsax.play), selectedIcon: Icon(Iconsax.play5), label: 'Courses'),
//                   NavigationDestination(
//                     icon: Icon(Iconsax.message),
//                     selectedIcon: Icon(Iconsax.message5),
//                     label: 'Chat',
//                   ),
//                   NavigationDestination(
//                     icon: Icon(Icons.person_outline),
//                     selectedIcon: Icon(Icons.person),
//                     label: 'Profile',
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// ,  import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'nav_event.dart';
// part 'nav_state.dart';

// class NavBloc extends Bloc<NavEvent, NavState> {
//   NavBloc() : super(const NavState()) {
//     on<NavTabChangedEvent>(_onNavTabChanged);
//     on<NavResetEvent>(_onNavReset);
//   }

//   void _onNavTabChanged(NavTabChangedEvent event, Emitter<NavState> emit) {
//     final index = event.index;
//     emit(state.copyWith(index: index));
//   }

//   void _onNavReset(NavResetEvent event, Emitter<NavState> emit) {
//     emit(const NavState(index: 0));
//   }
// }

