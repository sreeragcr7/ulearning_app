import 'package:flutter_bloc/flutter_bloc.dart';


class OnBoardingCubit extends Cubit<int> {
  OnBoardingCubit() : super(0);

  void pageChanged(int index) => emit(index);
}
