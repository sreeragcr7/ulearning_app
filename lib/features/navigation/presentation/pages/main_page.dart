import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ulearning_app/features/course/presentation/pages/course_page.dart';
import 'package:ulearning_app/features/home/presentation/pages/home_page.dart';
import 'package:ulearning_app/features/navigation/presentation/bloc/nav_bloc.dart';
import 'package:ulearning_app/features/profile/presentation/pages/profile_page.dart';
import 'package:ulearning_app/features/search/presentation/pages/search_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static const List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    CoursePage(),
    Center(child: Text("Chat Page")),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBloc, NavState>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,

          body: IndexedStack(index: state.index, children: _pages),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Theme.of(context).dividerColor.withAlpha(38), width: 1)),
            ),
            child: Material(
              shadowColor: Colors.transparent, // 👈 remove tonal shadow
              child: NavigationBar(
                backgroundColor: Theme.of(context).colorScheme.surface,
                surfaceTintColor: Colors.transparent, // 👈 VERY IMPORTANT
                shadowColor: Colors.transparent, // 👈 remove tonal shadow
                height: 65,
                elevation: 0,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                selectedIndex: state.index,
                onDestinationSelected: (index) {
                  context.read<NavBloc>().add(NavTabChangedEvent(index));
                },
                destinations: const [
                  NavigationDestination(icon: Icon(Iconsax.home_1), selectedIcon: Icon(Iconsax.home5), label: 'Home'),
                  NavigationDestination(
                    icon: Icon(Icons.search),
                    selectedIcon: Icon(Iconsax.search_normal),
                    label: 'Search',
                  ),
                  NavigationDestination(icon: Icon(Iconsax.play), selectedIcon: Icon(Iconsax.play5), label: 'Courses'),
                  NavigationDestination(
                    icon: Icon(Iconsax.message),
                    selectedIcon: Icon(Iconsax.message5),
                    label: 'Chat',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
