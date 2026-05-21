import 'package:supabase_flutter/supabase_flutter.dart' show AuthState;

import 'package:ulearning_app/core/usecases/t_stream_usecase.dart';
import 'package:ulearning_app/core/usecases/t_usecase.dart';
import 'package:ulearning_app/features/auth/domain/repository/auth_repository.dart';

class AuthStateChanges implements TStreamUsecase<AuthState, NoParams> {
  AuthStateChanges(this.authRepository);

  final AuthRepository authRepository;

  @override
  Stream<AuthState> call(NoParams params) {
    return authRepository.authStateChanges();
  }
}
