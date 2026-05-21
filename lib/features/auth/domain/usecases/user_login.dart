import 'package:fpdart/fpdart.dart';
import 'package:ulearning_app/core/common/entities/entities.dart';
import 'package:ulearning_app/core/error/failures.dart';
import 'package:ulearning_app/core/usecases/t_usecase.dart';
import 'package:ulearning_app/features/auth/domain/repository/auth_repository.dart';

class UserLogin implements TUsecase<User, LoginParams> {
  const UserLogin(this.authRepository);
  final AuthRepository authRepository;
  @override
  Future<Either<TFailure, User>> call(LoginParams params) async {
    return await authRepository.loginInEmailAndPassword(password: params.password, email: params.email);
  }
}

class LoginParams {
  const LoginParams({required this.email, required this.password});
  final String email;
  final String password;
}
