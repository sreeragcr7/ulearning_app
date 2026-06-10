import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/core/common/widgets/gradient/gradient_image_box.dart';
import 'package:ulearning_app/core/common/widgets/gradient/gradient_list.dart';
import 'package:ulearning_app/core/common/widgets/loader.dart';
import 'package:ulearning_app/core/common/widgets/search/search_filter.dart';
import 'package:ulearning_app/core/routes/app_routes.dart';
import 'package:ulearning_app/core/utils/constants/enums.dart';
import 'package:ulearning_app/core/utils/constants/sizes.dart';
import 'package:ulearning_app/features/course/presentation/bloc/course_bloc.dart';
import 'package:ulearning_app/features/course/presentation/bloc/course_state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: TSizes.screenPadding, vertical: TSizes.screenTop),
              child: const SearchFilter(),
            ),

            Expanded(
              child: BlocBuilder<CourseBloc, CourseState>(
                builder: (context, state) {
                  if (state.status == RequestStatus.loading) {
                    return const Loader();
                  }

                  if (state.status == RequestStatus.failure) {
                    return Center(child: Text(state.errorMessage ?? 'Something went wrong'));
                  }

                  final courses = state.searchedCourses;

                  if (courses.isEmpty) {
                    return const Center(child: Text('No courses found'));
                  }

                  return ListView.separated(
                    itemCount: courses.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 4),
                    itemBuilder: (context, index) {
                      final course = courses[index];

                      return GradientList(
                        leading: GradientImageBox(height: 75, width: 75, imageUrl: course.thumbnailUrl),
                        titleSize: 14,
                        title: course.title,
                        subTitle: course.subtitle,
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.courseDetails, arguments: course.id);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
