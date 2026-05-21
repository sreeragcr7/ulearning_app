part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class CheckSessionEvent extends AuthEvent {}

final class AuthStateChangedEvent extends AuthEvent {
  AuthStateChangedEvent(this.session);
  final supabase.Session? session;
}

final class LogInEvent extends AuthEvent {
  LogInEvent({required this.email, required this.password});
  final String email;
  final String password;
}

final class SignUpEvent extends AuthEvent {
  SignUpEvent({required this.email, required this.username, required this.password});
  final String username;
  final String email;
  final String password;
}

final class LogoutEvent extends AuthEvent {}

// final class AuthUserLoggedInEvent extends AuthEvent {}
