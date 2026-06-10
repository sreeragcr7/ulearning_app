import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ulearning_app/core/common/widgets/dot_indicator.dart';
import 'package:ulearning_app/core/common/widgets/loader.dart';
import 'package:ulearning_app/core/utils/constants/enums.dart';
import 'package:ulearning_app/features/banner/presentation/bloc/banner_bloc.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  late PageController _controller;
  int _currentIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {
        print('Banner State: ${state.status}');
        print('Banner Count: ${state.banners.length}');
        if (state.status == RequestStatus.loading) {
          return const Loader();
        }
        if (state.status == RequestStatus.failure) {
          return Center(child: Text(state.errorMessage ?? 'Failed to load banners'));
        }

        final banners = state.banners;

        if (banners.isEmpty) {
          return const SizedBox();
        }
        return Column(
          children: [
            SizedBox(
              height: 160,
              child: PageView.builder(
                controller: _controller,
                itemBuilder: (context, index) {
                  final bannerIndex = index % banners.length;

                  final banner = banners[bannerIndex];

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        banner.imageUrl,
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
                    _currentIndex = index % banners.length;
                  });
                },
              ),
            ),

            const SizedBox(height: 12),

            TDotIndicator(dotCount: banners.length, activeIndex: _currentIndex),
          ],
        );
      },
    );
  }
}
