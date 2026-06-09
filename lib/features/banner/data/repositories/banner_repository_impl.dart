import 'package:fpdart/fpdart.dart';
import 'package:ulearning_app/core/common/entities/banner.dart';
import 'package:ulearning_app/core/error/failures.dart';
import 'package:ulearning_app/core/utils/helpers/helper_function.dart';
import 'package:ulearning_app/features/banner/data/datasources/banner_remote_data_source.dart';
import 'package:ulearning_app/features/banner/domain/repository/banner_repository.dart';

class BannerRepositoryImpl implements BannerRepository {
  const BannerRepositoryImpl(this.remoteDataSource, this.repositoryHelper);
  final BannerRemoteDataSource remoteDataSource;
  final RepositoryHelper repositoryHelper;
  @override
  Future<Either<TFailure, List<AppBanner>>> getBanners() async {
    return repositoryHelper.execute(() => remoteDataSource.getBanners());
  }
}
