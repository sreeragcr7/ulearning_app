import 'package:flutter/material.dart';
import 'package:ulearning_app/core/common/widgets/gradient/gradient_list_view.dart';
import 'package:ulearning_app/core/common/widgets/search/search_filter.dart';
import 'package:ulearning_app/core/common/widgets/t_app_bar.dart';
import 'package:ulearning_app/core/utils/constants/sizes.dart';
import 'package:ulearning_app/features/search/presentation/widgets/search_list_item.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(icon: Icons.shopping_cart_outlined, title: 'Search'),

      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.screenPadding, vertical: TSizes.screenTop),
            child: const SearchFilter(),
          ),

          Expanded(child: GradientListView(items: searchItems)),
        ],
      ),
    );
  }
}
