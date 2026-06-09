import 'package:fpdart/fpdart.dart';
import 'package:ulearning_app/core/common/entities/banner.dart';
import 'package:ulearning_app/core/error/failures.dart';
import 'package:ulearning_app/core/usecases/t_usecase.dart';
import 'package:ulearning_app/features/banner/domain/repository/banner_repository.dart';

class BannersUsecase implements TUsecase<List<AppBanner>, NoParams> {
  const BannersUsecase(this.repository);
  final BannerRepository repository;
  @override
  Future<Either<TFailure, List<AppBanner>>> call(NoParams params) {
    return repository.getBanners();
  }
}
