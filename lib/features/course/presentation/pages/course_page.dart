import 'package:flutter/material.dart';
import 'package:ulearning_app/core/common/widgets/banner_carousel.dart';
import 'package:ulearning_app/core/common/widgets/gradient/gradient_list_view.dart';
import 'package:ulearning_app/core/common/widgets/search/search_filter.dart';
import 'package:ulearning_app/core/common/widgets/section_header.dart';
import 'package:ulearning_app/core/common/widgets/t_app_bar.dart';
import 'package:ulearning_app/core/utils/constants/sizes.dart';
import 'package:ulearning_app/features/course/presentation/widgets/course_list_items.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: 'Your Courses', icon: Icons.shopping_cart_outlined),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: TSizes.screenPadding, vertical: TSizes.screenTop),
              child: Column(
                children: [
                  BannerCarousel(),
                  SizedBox(height: TSizes.btwSection - 10),
                  SearchFilter(),
                  SizedBox(height: TSizes.btwSection - 10),
                  SectionHeader(title: 'All Courses', onSeeAll: () {}),
                ],
              ),
            ),
            GradientListView(items: yourCourseItems, shrinkWrap: true, physics: NeverScrollableScrollPhysics()),
          ],
        ),
      ),
    );
  }
}
