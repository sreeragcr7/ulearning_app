import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ulearning_app/features/banner/data/models/banner_model.dart';

abstract interface class BannerRemoteDataSource {
  Future<List<BannerModel>> getBanners();
}

class BannerRemoteDataSourceImpl implements BannerRemoteDataSource {
  const BannerRemoteDataSourceImpl({required this.supabase});
  final SupabaseClient supabase;
  @override
  Future<List<BannerModel>> getBanners() async {
    final response = await supabase.from('banners').select().eq('is_active', true);


    return response.map<BannerModel>((e) => BannerModel.fromJson(e)).toList();
  }
}
