import 'package:ulearning_app/core/common/entities/banner.dart';

class BannerModel extends AppBanner {
  const BannerModel({required super.id, required super.imagePath});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(id: json['id'], imagePath: json['image_url']);
  }
}
