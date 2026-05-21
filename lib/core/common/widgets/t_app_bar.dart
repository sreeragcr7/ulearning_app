import 'package:flutter/material.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({
    super.key,
    this.icon,
    this.showAvatar = false,
    this.title = '',
    this.backgroundColor,
    this.fontSize = 30,
    this.fontWeight = FontWeight.bold,
    this.color,
  });
  final IconData? icon;
  final bool showAvatar;
  final String title;
  final Color? backgroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleTextStyle: TextStyle(color: color),
      backgroundColor: backgroundColor,
      title: Text(title, style: Theme.of(context).textTheme.titleLarge),
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: showAvatar
              ? CircleAvatar(radius: 16, child: Icon(icon, size: 18))
              : IconButton(onPressed: () {}, icon: Icon(icon)),
        ),
      ],
    );
  }
}
