import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/core/common/entities/banner.dart';
import 'package:ulearning_app/core/usecases/t_usecase.dart';
import 'package:ulearning_app/core/utils/constants/enums.dart';
import 'package:ulearning_app/features/banner/domain/usecases/banners_usecase.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc({required BannersUsecase bannersUsecase}) : _bannersUsecase = bannersUsecase, super(const BannerState()) {
    on<LoadBanners>(_onLoadBanners);
  }

  final BannersUsecase _bannersUsecase;

  Future<void> _onLoadBanners(LoadBanners event, Emitter<BannerState> emit) async {

    emit(state.copyWith(status: RequestStatus.loading));

    final result = await _bannersUsecase(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(status: RequestStatus.failure, errorMessage: failure.message)),
      (banners) => emit(state.copyWith(status: RequestStatus.success, banners: banners)),
    );
  }
}
