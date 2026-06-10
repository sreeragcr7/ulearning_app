import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/core/common/widgets/gradient/gradient_image_box.dart';
import 'package:ulearning_app/core/common/widgets/gradient/gradient_list.dart';
import 'package:ulearning_app/core/common/widgets/loader.dart';
import 'package:ulearning_app/core/common/widgets/search/search_filter.dart';
import 'package:ulearning_app/core/common/widgets/section_header.dart';
import 'package:ulearning_app/core/common/widgets/t_app_bar.dart';
import 'package:ulearning_app/core/routes/app_routes.dart';
import 'package:ulearning_app/core/utils/constants/enums.dart';
import 'package:ulearning_app/core/utils/constants/sizes.dart';
import 'package:ulearning_app/features/course/presentation/bloc/course_bloc.dart';
import 'package:ulearning_app/features/course/presentation/bloc/course_state.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  void initState() {
    super.initState();

    final bloc = context.read<CourseBloc>();
    if (bloc.state.allCourses.isEmpty) {
      bloc.add(LoadCourses());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: 'Your Courses', icon: Icons.shopping_cart_outlined),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: TSizes.screenPadding - 10, vertical: TSizes.screenTop),
                child: Column(
                  children: [
                    SearchFilter(),
                    SizedBox(height: TSizes.btwSection - 10),
                    SectionHeader(title: 'All Courses', onSeeAll: () {}),
                  ],
                ),
              ),
            ),

            BlocBuilder<CourseBloc, CourseState>(
              builder: (context, state) {
                if (state.status == RequestStatus.loading) {
                  return const SliverFillRemaining(child: Center(child: Loader()));
                }

                if (state.status == RequestStatus.failure) {
                  return SliverFillRemaining(child: Center(child: Text(state.errorMessage ?? 'Something went wrong')));
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final course = state.allCourses[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: GradientList(
                        titleSize: 14,
                        leading: GradientImageBox(height: 80, width: 80, imageUrl: course.thumbnailUrl),
                        trailing: Text(
                          '₹${course.price}',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        title: course.title,
                        subTitle: '${course.totalLessons} Lessons',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.courseDetails, arguments: course.id);
                        },
                      ),
                    );
                  }, childCount: state.allCourses.length),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
