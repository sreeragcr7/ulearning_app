import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'nav_event.dart';
part 'nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(const NavState()) {
    on<NavTabChangedEvent>(_onNavTabChanged);
    on<NavResetEvent>(_onNavReset);
  }

  void _onNavTabChanged(NavTabChangedEvent event, Emitter<NavState> emit) {
    final index = event.index;
    emit(state.copyWith(index: index));
  }

  void _onNavReset(NavResetEvent event, Emitter<NavState> emit) {
    emit(const NavState(index: 0));
  }
}
