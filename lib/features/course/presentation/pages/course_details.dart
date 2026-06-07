import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ulearning_app/core/common/widgets/common_button.dart';
import 'package:ulearning_app/core/common/widgets/gradient/gradient_icon_box.dart';
import 'package:ulearning_app/core/common/widgets/gradient/gradient_image_box.dart';
import 'package:ulearning_app/core/common/widgets/gradient/gradient_list.dart';
import 'package:ulearning_app/core/common/widgets/icon_count.dart';
import 'package:ulearning_app/core/common/widgets/t_app_bar.dart';
import 'package:ulearning_app/core/utils/constants/sizes.dart';
import 'package:ulearning_app/features/course/presentation/widgets/course_list_items.dart';
import 'package:ulearning_app/core/common/widgets/section_header.dart';

class CourseDetailsPage extends StatelessWidget {
  const CourseDetailsPage({super.key, required this.title, required this.subTitle, required this.imageUrl});

  final String title;
  final String subTitle;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: 'Course details'),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              /// PADDED CONTENT
              Padding(
                padding: EdgeInsets.symmetric(horizontal: TSizes.screenPadding),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    /// IMAGE
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(imageUrl, width: double.infinity, height: 200, fit: BoxFit.cover),
                    ),

                    SizedBox(height: TSizes.btwItems - 2),

                    /// TOP ROW
                    Row(
                      children: [
                        ActionChip(
                          side: BorderSide.none,
                          backgroundColor: Colors.deepPurple,

                          label: const Text(
                            'Author Page',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                          ),

                          onPressed: () {},

                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),

                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),

                        const SizedBox(width: 30),

                        const IconCount(icon: Icons.people, count: '0', size: 24, fontSize: 15),

                        const SizedBox(width: 30),

                        const IconCount(icon: Iconsax.star1, count: '5', size: 24, fontSize: 15),
                      ],
                    ),

                    SizedBox(height: TSizes.btwItems - 5),

                    const SectionHeader(title: 'Course Description'),

                    SizedBox(height: TSizes.btwItems - 5),

                    Text(description, style: TextStyle(color: Colors.grey)),

                    SizedBox(height: TSizes.btwSection),

                    CommonBtn(btn: 'Go Buy', onPressed: () {}),

                    SizedBox(height: TSizes.btwSection),

                    const SectionHeader(title: 'This Course Includes', fontSize: 15),

                    SizedBox(height: TSizes.btwItems - 10),
                  ],
                ),
              ),

              //Abot info
              GradientList(
                leading: GradientIconBox(icon: Icons.videocam),
                title: '36 Houres Video',
                // iconSize: 20,
                // height: 30,
                // width: 30,
                titleSize: 14,
              ),
              GradientList(
                leading: GradientIconBox(icon: Iconsax.book),
                title: 'Total 36 Lessons',
                // iconSize: 20,
                // height: 30,
                // width: 30,
                titleSize: 14,
              ),
              GradientList(
                leading: GradientIconBox(icon: Icons.cloud),
                title: '67 Downloaded resources',
                // iconSize: 20,
                // height: 30,
                // width: 30,
                titleSize: 14,
              ),

              SizedBox(height: TSizes.btwItems - 10),

              /// LESSON LIST HEADER
              Padding(
                padding: EdgeInsets.symmetric(horizontal: TSizes.screenPadding),

                child: const SectionHeader(title: 'Lesson List'),
              ),

              SizedBox(height: TSizes.btwItems - 10),

              GradientList(
                title: 'UI Design',
                subTitle: 'UI Design',
                leading: GradientImageBox(imageUrl: imageUrl),

                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
