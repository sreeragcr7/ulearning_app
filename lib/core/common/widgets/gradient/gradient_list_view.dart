import 'package:flutter/material.dart';
import 'package:ulearning_app/core/common/widgets/gradient/gradient_list.dart';
import 'package:ulearning_app/core/common/widgets/gradient/gradient_list_model.dart';

class GradientListView extends StatelessWidget {
  const GradientListView({super.key, required this.items, this.contentPadding, this.shrinkWrap = false, this.physics});

  final List<GradientListModel> items;
  final EdgeInsetsGeometry? contentPadding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: const EdgeInsets.only(bottom: 20),

      separatorBuilder: (_, _) => const SizedBox(height: 4),

      itemBuilder: (context, index) {
        final item = items[index];

        return GradientList(
          leading: item.leading,
          title: item.title,
          subTitle: item.subTitle,
          trailing: item.trailing,
          titleSize: item.titleSize,
          contentPadding: contentPadding,
          onTap: item.route == null ? null : () => Navigator.pushNamed(context, item.route!),
        );
      },
    );
  }
}
