import 'package:connectivity_plus/connectivity_plus.dart';

extension ConnectivityResultExtention on ConnectivityResult {
  bool hasValidConnection() {
    switch (this) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
        return true;
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.none:
      default:
        return false;
    }
  }
}
