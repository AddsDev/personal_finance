abstract class NetworkInfo {
  Stream<bool> get isConnectedStream;

  Future<bool> get isConnected;
}