import 'package:connectivity_plus/connectivity_plus.dart';

/// Abstract class for network connectivity checking
abstract class NetworkInfo {
  /// Returns true if device is connected to internet
  Future<bool> get isConnected;
}

/// Implementation of NetworkInfo using connectivity_plus package
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    try {
      final List<ConnectivityResult> connectivityResults = await connectivity
          .checkConnectivity();
      return connectivityResults.isNotEmpty &&
          connectivityResults.any(
            (result) => result != ConnectivityResult.none,
          );
    } catch (e) {
      return false;
    }
  }
}
