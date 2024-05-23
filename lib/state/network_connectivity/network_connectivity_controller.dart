import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_demo_project/state/network_connectivity/network_connectivity_result_extension.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'network_connectivity_controller.g.dart';

@Riverpod(keepAlive: true)
class NetworkStatus extends _$NetworkStatus {
  @override
  bool build() {
    bool? isConnected;
    Connectivity().onConnectivityChanged.listen((onData) {
      for (var e in onData) {
        isConnected = e.hasValidConnection();
      }
      if (isConnected != null) {
        state = isConnected!;
      }
    });
    return isConnected ?? false;
  }
}
