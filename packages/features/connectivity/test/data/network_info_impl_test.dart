import 'package:connectivity/data/network_info_impl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late NetworkInfoImpl networkInfo;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfo = NetworkInfoImpl(connectivity: mockConnectivity);
  });

  group('isConnected', () {
    test('return true when connectivity result is mobile', () async {
      when(
        () => mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.mobile]);

      final result = await networkInfo.isConnected;

      expect(result, true);
    });

    test('return true when connectivity result is wifi', () async {
      when(
        () => mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);

      final result = await networkInfo.isConnected;

      expect(result, true);
    });

    test('return false when connectivity result is none', () async {
      when(
        () => mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.none]);

      final result = await networkInfo.isConnected;

      expect(result, false);
    });
  });

  group('isConnectedStream', () {
    test('emit true when connectivity changes to mobile', () {
      when(
        () => mockConnectivity.onConnectivityChanged,
      ).thenAnswer((_) => Stream.value([ConnectivityResult.mobile]));

      final stream = networkInfo.isConnectedStream;

      expect(stream, emits(true));
    });

    test('emit false when connectivity changes to none', () {
      when(
        () => mockConnectivity.onConnectivityChanged,
      ).thenAnswer((_) => Stream.value([ConnectivityResult.none]));

      final stream = networkInfo.isConnectedStream;

      expect(stream, emits(false));
    });
  });
}
