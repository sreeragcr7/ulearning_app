import 'package:flutter/material.dart';
import 'package:ulearning_app/core/utils/helpers/helper_function.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({super.key});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  final List<String> categories = ['All', 'Popular', 'Newest'];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunction.isDarkMode(context);

    return SizedBox(
      height: 44, // little bigger
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

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
                setState(() {
                  selectedIndex = index;
                });
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
  }
}
