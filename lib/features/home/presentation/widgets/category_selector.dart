import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/core/utils/constants/enums.dart';
import 'package:ulearning_app/core/utils/helpers/helper_function.dart';
import 'package:ulearning_app/features/course/presentation/bloc/course_bloc.dart';
import 'package:ulearning_app/features/course/presentation/bloc/course_state.dart';

class CategorySelector extends StatelessWidget {
  CategorySelector({super.key});

  final List<String> categories = ['All', 'Popular', 'Newest'];
  final filters = [CourseFilter.all, CourseFilter.popular, CourseFilter.newest];

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunction.isDarkMode(context);

    return BlocBuilder<CourseBloc, CourseState>(
      builder: (context, state) {
        return SizedBox(
          height: 44, // little bigger
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final isSelected = state.selectedFilter == filters[index];

              return Container(
                padding: const EdgeInsets.all(2), // 👈 makes gradient thicker
                decoration: isSelected
                    ? BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFF7B1FA2), Color(0xFF512DA8)]),
                        borderRadius: BorderRadius.circular(22),
                      )
                    : null,
                child: ChoiceChip(
                  label: Text(
                    categories[index],
                    style: TextStyle(color: isSelected ? (isDark ? Colors.white : Colors.black) : null),
                  ),
                  selected: isSelected,
                  onSelected: (_) {
                    context.read<CourseBloc>().add(ChangeCourseFilter(filters[index]));
                  },
                  showCheckmark: false,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  selectedColor: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
