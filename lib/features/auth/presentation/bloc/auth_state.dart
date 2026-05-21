part of 'auth_bloc.dart';

@immutable
sealed class AuthBlocState {}

final class AuthInitial extends AuthBlocState {}

final class AuthCheckingSession extends AuthBlocState {}

final class AuthLoading extends AuthBlocState {}

final class AuthAuthenticated extends AuthBlocState {}

final class AuthEmailVerificationPending extends AuthBlocState {
  AuthEmailVerificationPending(this.email);
  final String email;
}

final class AuthFailure extends AuthBlocState {
  AuthFailure(this.message);
  final String message;
}

final class AuthLoggedOut extends AuthBlocState {}
