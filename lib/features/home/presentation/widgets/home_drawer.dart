import 'package:flutter/material.dart';
import 'package:ulearning_app/core/routes/app_routes.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({required this.onLogout, super.key});

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(),
      child: ListView(
        children: [
          const DrawerHeader(child: Text('Ulearning')),
          ListTile(leading: const Icon(Icons.book), title: const Text('My Courses'), onTap: () {}),
          ListTile(leading: const Icon(Icons.settings), title: const Text('Settings'), onTap: () {}),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
