import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ulearning_app/core/common/widgets/gradient/gradient_icon_box.dart';
import 'package:ulearning_app/core/common/widgets/gradient/gradient_image_box.dart';
import 'package:ulearning_app/core/common/widgets/gradient/gradient_list_model.dart';

final List<GradientListModel> courseIncludesItems = [
  GradientListModel(
    leading: GradientIconBox(icon: Icons.videocam),
    title: '36 Houres Video',
  ),
  GradientListModel(
    leading: GradientIconBox(icon: Iconsax.book),
    title: 'Total 36 Lessons',
  ),
  GradientListModel(
    leading: GradientIconBox(icon: Icons.cloud),
    title: '67 Downloaded resources',
  ),
];

final List<GradientListModel> yourCourseItems = [
  GradientListModel(
    leading: GradientImageBox(imageUrl: 'https://picsum.photos/400/300?random=1', height: 80, width: 80),
    title: 'Visual Identity',
    subTitle: '30 Lessons',
    trailing: Text('\$12.00'),
  ),
  GradientListModel(
    leading: GradientImageBox(imageUrl: 'https://picsum.photos/400/300?random=2', height: 80, width: 80),
    title: 'User Interface',
    subTitle: '30 Lesson',
    trailing: Text('\$12.00'),
  ),
  GradientListModel(
    leading: GradientImageBox(imageUrl: 'https://picsum.photos/400/300?random=3', height: 80, width: 80),
    title: 'Marketing ',
    subTitle: '30 Lesson',
    trailing: Text('\$60.00'),
  ),
  GradientListModel(
    leading: GradientImageBox(imageUrl: 'https://picsum.photos/400/300?random=4', height: 80, width: 80),
    title: 'Packaging Design',
    subTitle: '30 Lesson',
    trailing: Text('\$20.00'),
  ),
  GradientListModel(
    leading: GradientImageBox(imageUrl: 'https://picsum.photos/400/300?random=5', height: 80, width: 80),
    title: 'Packaging Design',
    subTitle: '30 Lesson',
    trailing: Text('\$7.50'),
  ),
];

final String description =
    'Visual Identity is the complete visual representation of a brand through colors, typography, logos, imagery, and design systems. In this course, you will learn how to create strong and memorable brand identities that communicate personality, values, and emotions effectively.';
