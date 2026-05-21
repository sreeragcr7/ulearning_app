import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ulearning_app/core/common/widgets/gradient/gradient_icon_box.dart';
import 'package:ulearning_app/core/routes/app_routes.dart';
import 'package:ulearning_app/core/common/widgets/gradient/gradient_list_model.dart';

final List<GradientListModel> profileItems = [
  GradientListModel(
    leading: GradientIconBox(icon: Icons.settings),
    title: 'Settings',
    route: AppRoutes.settings,
  ),
  GradientListModel(
    leading: GradientIconBox(icon: Icons.payment),
    title: 'Payment details',
  ),
  GradientListModel(
    leading: GradientIconBox(icon: Iconsax.medal_star5),
    title: 'Achievements',
  ),
  GradientListModel(
    leading: GradientIconBox(icon: Iconsax.heart5),
    title: 'Favourite',
  ),
  GradientListModel(
    leading: GradientIconBox(icon: Iconsax.alarm5),
    title: 'Learning reminders',
  ),
];
