import 'package:flutter/material.dart';
import 'package:ulearning_app/core/routes/app_routes.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.title, required this.imageUrl, required this.subtitle});

  final String title;
  final String subtitle;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.courseDetails,
          arguments: {'title': title, 'subTitle': subtitle, 'imageUrl': imageUrl},
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: imageUrl.isEmpty
                  ? Container(color: color.surfaceContainerHighest)
                  : Image.network(imageUrl, fit: BoxFit.cover),
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
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4), // spacing between title & subtitle
                  Text(
                    subtitle,
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
