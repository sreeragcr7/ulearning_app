import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/core/common/entities/user.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void setUser(User user) {
    emit(AppUserAuthenticated(user));
  }

  void clearUser() {
    emit(AppUserUnauthenticated());
  }
}
