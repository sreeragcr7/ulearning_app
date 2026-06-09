part of 'banner_bloc.dart';

sealed class BannerEvent {
  const BannerEvent();
}

final class LoadBanners extends BannerEvent {}
