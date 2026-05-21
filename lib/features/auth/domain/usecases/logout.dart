import 'package:fpdart/fpdart.dart';
import 'package:ulearning_app/core/error/failures.dart';
import 'package:ulearning_app/core/usecases/t_usecase.dart';
import 'package:ulearning_app/features/auth/domain/repository/auth_repository.dart';

class Logout implements TUsecase<void, NoParams> {
  Logout(this.authRepository);
  final AuthRepository authRepository;
  @override
  Future<Either<TFailure, void>> call(NoParams params) {
    return authRepository.logout();
  }
}
