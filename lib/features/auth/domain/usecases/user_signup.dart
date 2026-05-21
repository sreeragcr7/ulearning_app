import 'package:fpdart/fpdart.dart';
import 'package:ulearning_app/core/error/failures.dart';
import 'package:ulearning_app/core/usecases/t_usecase.dart';
import 'package:ulearning_app/features/auth/domain/repository/auth_repository.dart';

class UserSignup implements TUsecase<void, SignUpParams> {
  const UserSignup(this.authRepository);
  final AuthRepository authRepository;
  @override
  Future<Either<TFailure, void>> call(SignUpParams params) async {
    return await authRepository.signupEmailAndPassword(
      password: params.password,
      email: params.email,
      username: params.username,
    );
  }
}

class SignUpParams {
  const SignUpParams({required this.username, required this.email, required this.password});
  final String username;
  final String email;
  final String password;
}
