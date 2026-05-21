import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ulearning_app/core/common/widgets/dot_indicator.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  late PageController _controller;
  int _currentIndex = 0;

  final List<String> _images = ['assets/icons/Art.png', 'assets/icons/image_1.png', 'assets/icons/image_2.png'];

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      viewportFraction: 0.92,
      initialPage: 1000, // start in middle for infinite scroll
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _controller,
            itemBuilder: (context, index) {
              final imageIndex = index % _images.length;

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    _images[imageIndex],
                    fit: BoxFit.cover,
                    frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded) return child;

                      return frame == null
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(color: Colors.white),
                            )
                          : child;
                    },
                  ),
                ),
              );
            },
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index % _images.length;
              });
            },
          ),
        ),

        const SizedBox(height: 12),

        TDotIndicator(dotCount: _images.length, activeIndex: _currentIndex),
      ],
    );
  }
}
