abstract interface class TStreamUsecase<SuccessType, Params> {
  Stream<SuccessType> call(Params params);
}

