import 'package:flutter/cupertino.dart';

class GradientListModel {
  const GradientListModel({
    required this.leading,
    required this.title,
    this.route,
    this.subTitle,
    this.trailing,
    this.titleSize,
  });
  final Widget leading;
  final String title;
  final String? route;
  final String? subTitle;
  final Widget? trailing;
  final double? titleSize;
}
