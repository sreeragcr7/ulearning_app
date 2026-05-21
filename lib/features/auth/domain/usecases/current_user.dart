import 'package:fpdart/fpdart.dart';
import 'package:ulearning_app/core/common/entities/entities.dart';
import 'package:ulearning_app/core/error/failures.dart';
import 'package:ulearning_app/core/usecases/t_usecase.dart';
import 'package:ulearning_app/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements TUsecase<User, NoParams> {
  CurrentUser(this.authRepository);
  final AuthRepository authRepository;
  @override
  Future<Either<TFailure, User>> call(params) async {
    return await authRepository.currentUser();
  }
}
