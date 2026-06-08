import 'package:flutter/material.dart';
import 'package:ulearning_app/core/common/entities/course.dart';
import 'package:ulearning_app/features/course/presentation/widgets/course_card.dart';

class CourseGrid extends StatelessWidget {
  const CourseGrid({super.key, required this.courses});

  final List<Course> courses;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: courses.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.3,
      ),
      itemBuilder: (context, index) {
        final course = courses[index];
        return CourseCard(course: course);
      },
    );
  }
}
