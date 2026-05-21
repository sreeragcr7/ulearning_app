import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class InternetConnectionCheck {
  Future<bool> get isConnected;
}

class InternetConnectionCheckImpl implements InternetConnectionCheck {
  InternetConnectionCheckImpl(this.internetConnection);
  final InternetConnection internetConnection;
  @override
  Future<bool> get isConnected async => await internetConnection.hasInternetAccess;
}
