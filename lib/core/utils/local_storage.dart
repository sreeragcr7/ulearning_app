import 'package:hive_flutter/hive_flutter.dart';

class LocalStorages {
  LocalStorages(this.box);
  final Box box;

  static const _onboardinKey = 'onboarding_done';

  bool isOnboardingDone() {
    return box.get(_onboardinKey, defaultValue: false);
  }

  Future<void> setOnboardingDone() async {
    await box.put(_onboardinKey, true);
  }
}
