part of 'banner_bloc.dart';

class BannerState extends Equatable {
  const BannerState({this.banners = const [], this.errorMessage, this.status = RequestStatus.initial});

  final RequestStatus status;
  final List<AppBanner> banners;
  final String? errorMessage;


  BannerState copyWith({RequestStatus? status, List<AppBanner>? banners, String? errorMessage}) {
    return BannerState(
      status: status ?? this.status,
      banners: banners ?? this.banners,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
  
  @override
  List<Object?> get props => [status, banners, errorMessage];
}
