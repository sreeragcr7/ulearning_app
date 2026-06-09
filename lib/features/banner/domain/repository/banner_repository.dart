import 'package:fpdart/fpdart.dart';
import 'package:ulearning_app/core/common/entities/banner.dart';
import 'package:ulearning_app/core/error/failures.dart';

abstract interface class BannerRepository {
  Future<Either<TFailure, List<AppBanner>>> getBanners();
}
