import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ulearning_app/core/error/exceptions.dart';
import 'package:ulearning_app/core/error/failures.dart';
import 'package:ulearning_app/core/network/internet_connection_check.dart';
import 'package:ulearning_app/core/utils/constants/topics.dart';

class THelperFunction {
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}

class RepositoryHelper {
  const RepositoryHelper(this.internetConnectionCheck);
  final InternetConnectionCheck internetConnectionCheck;

  Future<Either<TFailure, T>> execute<T>(Future<T> Function() fn) async {
    try {
      if (!await internetConnectionCheck.isConnected) {
        return left(NetworkFailure(Constance.noConnectionErrorMessage));
      }

      final result = await fn();
      return right(result);
    } on AuthExceptions catch (e) {
      return left(AuthFailure(e.message));
    } on ServerExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: stackTrace);

      return left(ServerFailure('Something went wrong'));
    }
  }
}
