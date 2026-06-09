import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppBanner extends Equatable {
  const AppBanner({required this.id, required this.imagePath});
  final String id;
  final String imagePath;
  String get imageUrl => Supabase.instance.client.storage.from('banner-images').getPublicUrl(imagePath);

  @override
  List<Object?> get props => [id, imagePath, imageUrl];
}
