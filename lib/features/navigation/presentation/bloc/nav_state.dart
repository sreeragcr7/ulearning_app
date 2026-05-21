part of 'nav_bloc.dart';

@immutable
class NavState {
  final int index;
  const NavState({this.index = 0});

  NavState copyWith({int? index}) {
    return NavState(index: index ?? this.index);
  }
}