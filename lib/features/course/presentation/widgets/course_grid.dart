import 'package:flutter/material.dart';
import 'package:ulearning_app/features/course/presentation/widgets/course_card.dart';
import 'package:ulearning_app/mock_course_data.dart';

class CourseGrid extends StatelessWidget {
  const CourseGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: mockCourses.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.3,
      ),
      itemBuilder: (context, index) {
        final course = mockCourses[index];
        return CourseCard(title: course.title, subtitle: course.subtitle, imageUrl: course.imageUrl);
      },
    );
  }
}
