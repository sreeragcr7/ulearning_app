import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase hide User;

import 'package:ulearning_app/core/common/cubit/app_user_cubit.dart';
import 'package:ulearning_app/core/common/entities/user.dart';
import 'package:ulearning_app/core/usecases/t_usecase.dart';

import 'package:ulearning_app/features/auth/domain/usecases/auth_state_changes.dart';
import 'package:ulearning_app/features/auth/domain/usecases/current_user.dart';
import 'package:ulearning_app/features/auth/domain/usecases/logout.dart';
import 'package:ulearning_app/features/auth/domain/usecases/user_login.dart';
import 'package:ulearning_app/features/auth/domain/usecases/user_signup.dart';

import 'package:ulearning_app/features/navigation/presentation/bloc/nav_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthBlocState> {
  AuthBloc({
    required UserLogin userLogin,
    required UserSignup userSignup,
    required CurrentUser currentUser,
    required Logout logout,
    required AppUserCubit appUserCubit,
    required NavBloc navBloc,
    required AuthStateChanges authStateChanges,
  }) : _userLogin = userLogin,
       _userSignup = userSignup,
       _currentUser = currentUser,
       _logout = logout,
       _appUserCubit = appUserCubit,
       _navBloc = navBloc,
       _authStateChanges = authStateChanges,
       super(AuthCheckingSession()) {
    on<LogInEvent>(_onLoginEvent);
    on<SignUpEvent>(_onSignupEvent);
    on<LogoutEvent>(_onLogoutEvent);
    on<CheckSessionEvent>(_onCheckSession);
    on<AuthStateChangedEvent>(_onAuthStateChanged);

    /// START LISTENER
    _authSubscription = _authStateChanges(NoParams()).listen((data) {
      add(AuthStateChangedEvent(data.session));
    });
  }

  final UserLogin _userLogin;
  final UserSignup _userSignup;
  final CurrentUser _currentUser;
  final Logout _logout;
  final AppUserCubit _appUserCubit;
  final NavBloc _navBloc;
  final AuthStateChanges _authStateChanges;

  late final StreamSubscription<supabase.AuthState> _authSubscription;

  void _emitAuthSuccess(User user, Emitter<AuthBlocState> emit) {
    _appUserCubit.setUser(user);

    emit(AuthAuthenticated());
  }

  Future<void> _onAuthStateChanged(AuthStateChangedEvent event, Emitter<AuthBlocState> emit) async {
    if (event.session == null) {
      _appUserCubit.clearUser();

      emit(AuthLoggedOut());
    } else {
      add(CheckSessionEvent());
    }
  }

  Future<void> _onCheckSession(CheckSessionEvent event, Emitter<AuthBlocState> emit) async {
    emit(AuthCheckingSession());

    final res = await _currentUser(NoParams());

    res.fold(
      (_) {
        _appUserCubit.clearUser();

        emit(AuthInitial());
      },
      (user) {
        _appUserCubit.setUser(user);

        emit(AuthAuthenticated());
      },
    );
  }

  Future<void> _onLoginEvent(LogInEvent event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoading());

    final res = await _userLogin(LoginParams(email: event.email, password: event.password));

    res.fold(
      (error) {
        emit(AuthFailure(error.message));
      },
      (_) {
        /// Supabase auth listener will handle session update
      },
    );
  }

  Future<void> _onSignupEvent(SignUpEvent event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoading());

    final res = await _userSignup(SignUpParams(username: event.username, email: event.email, password: event.password));

    res.fold(
      (error) {
        emit(AuthFailure(error.message));
      },
      (_) {
        emit(AuthEmailVerificationPending(event.email));
      },
    );
  }

  Future<void> _onLogoutEvent(LogoutEvent event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoading());

    final res = await _logout(NoParams());

    res.fold((error) => emit(AuthFailure(error.message)), (_) {
      _appUserCubit.clearUser();

      _navBloc.add(NavResetEvent());

      emit(AuthLoggedOut());
    });
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();

    return super.close();
  }
}
