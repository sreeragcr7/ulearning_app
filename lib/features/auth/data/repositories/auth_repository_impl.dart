import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show AuthState;
import 'package:ulearning_app/core/common/entities/user.dart';
import 'package:ulearning_app/core/error/exceptions.dart';
import 'package:ulearning_app/core/error/failures.dart';
import 'package:ulearning_app/core/network/internet_connection_check.dart';
import 'package:ulearning_app/core/utils/constants/topics.dart';
import 'package:ulearning_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ulearning_app/features/auth/data/models/user_model.dart';
import 'package:ulearning_app/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this.authRemoteDataSource, this.internetConnectionCheck);

  final AuthRemoteDataSource authRemoteDataSource;
  final InternetConnectionCheck internetConnectionCheck;

  @override
  Future<Either<TFailure, User>> currentUser() async {
    try {
      final hasConnection = await internetConnectionCheck.isConnected;

      final session = authRemoteDataSource.currentUserSession;

      if (session == null) {
        return left(AuthFailure('User not logged in!'));
      }

      if (hasConnection) {
        final user = await authRemoteDataSource.getCurrentUserData();

        if (user != null) {
          return right(user);
        }
      }

      return right(
        UserModel(
          id: session.user.id,
          username: '',
          avatar: '',
          email: session.user.email ?? '',
        ),
      );
    } on AuthExceptions catch (e) {
      return left(AuthFailure(e.message));
    } on ServerExceptions catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  Future<Either<TFailure, T>> _execute<T>(Future<T> Function() fn) async {
    try {
      if (!await internetConnectionCheck.isConnected) {
        return left(NetworkFailure(Constance.noConnectionErrorMessage));
      }

      final result = await fn();

      return right(result);
    } on AuthExceptions catch (e) {
      return left(AuthFailure(e.message));
    } on ServerExceptions catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<TFailure, User>> loginInEmailAndPassword({required String password, required String email}) async {
    return _execute(() => authRemoteDataSource.logInEmailAndPassword(email: email, password: password));
  }

  @override
  Future<Either<TFailure, void>> signupEmailAndPassword({
    required String password,
    required String email,
    required String username,
  }) async {
    return _execute(
      () => authRemoteDataSource.signUpEmailAndPassword(email: email, password: password, username: username),
    );
  }

  @override
  Future<Either<TFailure, void>> logout() async {
    try {
      if (!await internetConnectionCheck.isConnected) {
        return left(NetworkFailure(Constance.noConnectionErrorMessage));
      }

      await authRemoteDataSource.logout();

      return const Right(null);
    } on AuthExceptions catch (e) {
      return left(AuthFailure(e.message));
    } on ServerExceptions catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Stream<AuthState> authStateChanges() {
    return authRemoteDataSource.authStateChanges;
  }
}
