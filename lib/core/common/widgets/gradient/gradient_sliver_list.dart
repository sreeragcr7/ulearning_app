import 'package:flutter/material.dart';
import 'package:ulearning_app/core/common/widgets/gradient/gradient_list.dart';
import 'package:ulearning_app/core/common/widgets/gradient/gradient_list_model.dart';

class GradientSliverList extends StatelessWidget {
  const GradientSliverList({
    super.key,
    required this.items,
    this.contentPadding,
  });

  final List<GradientListModel> items;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 20),
      sliver: SliverList.separated(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return GradientList(
            leading: item.leading,
            title: item.title,
            subTitle: item.subTitle,
            trailing: item.trailing,
            titleSize: item.titleSize,
            contentPadding: contentPadding,
            onTap: item.route != null
                ? () => Navigator.pushNamed(
                    context,
                    item.route!,
                  )
                : null,
          );
        },
        separatorBuilder: (_, _) => const SizedBox(height: 4),
      ),
    );
  }
}