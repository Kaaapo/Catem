import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_info.g.dart';

abstract interface class NetworkInfo {
  Future<bool> get isConnected;

  Stream<bool> get onStatusChange;
}

class ConnectivityNetworkInfo implements NetworkInfo {
  const ConnectivityNetworkInfo(this._connectivity);

  final Connectivity _connectivity;

  @override
  Future<bool> get isConnected async =>
      _hasConnection(await _connectivity.checkConnectivity());

  @override
  Stream<bool> get onStatusChange =>
      _connectivity.onConnectivityChanged.map(_hasConnection);

  static bool _hasConnection(List<ConnectivityResult> results) =>
      results.any((r) => r != ConnectivityResult.none);
}

@Riverpod(keepAlive: true)
NetworkInfo networkInfo(Ref ref) => ConnectivityNetworkInfo(Connectivity());

@riverpod
Stream<bool> isOnline(Ref ref) => ref.watch(networkInfoProvider).onStatusChange;
