import 'package:fpdart/fpdart.dart';
import 'package:ulearning_app/core/error/failures.dart';

abstract interface class TUsecase<SuccessType, Params> {
  Future<Either<TFailure, SuccessType>> call(Params params);
}

class NoParams {}
