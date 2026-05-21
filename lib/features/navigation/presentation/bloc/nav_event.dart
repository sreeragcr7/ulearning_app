part of 'nav_bloc.dart';

@immutable
sealed class NavEvent {}

class NavTabChangedEvent extends NavEvent {
  final int index;
  NavTabChangedEvent(this.index);
}

class NavResetEvent extends NavEvent {}