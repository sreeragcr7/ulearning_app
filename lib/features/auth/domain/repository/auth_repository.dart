import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show AuthState; // import only AuthState
import 'package:ulearning_app/core/common/entities/entities.dart';
import 'package:ulearning_app/core/error/failures.dart';

abstract interface class AuthRepository {
  // Session
  Future<Either<TFailure, User>> currentUser();

  // Auth listener
  Stream<AuthState> authStateChanges();

  // Login
  Future<Either<TFailure, User>> loginInEmailAndPassword({
    required String password,
    required String email,
  });

  // Signup
  Future<Either<TFailure, void>> signupEmailAndPassword({
    required String password,
    required String email,
    required String username,
  });

  // Logout
  Future<Either<TFailure, void>> logout();
}