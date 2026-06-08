import 'package:flutter/material.dart';
import 'package:ulearning_app/core/common/entities/course.dart';
import 'package:ulearning_app/core/routes/app_routes.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.courseDetails,
          arguments: course.id,
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: course.thumbnailUrl.isEmpty
                  ? Container(color: color.surfaceContainerHighest)
                  : Image.network(course.thumbnailUrl, fit: BoxFit.cover),
            ),

            // Gradient overlay (for readability)
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [color.scrim.withAlpha(153), Colors.transparent],
                  ),
                ),
              ),
            ),

            // Title text
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    course.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4), // spacing between title & subtitle
                  Text(
                    course.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white.withAlpha(180)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
