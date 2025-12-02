import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late ConnectivityBloc bloc;
  late MockNetworkInfo mockNetworkInfo;
  late StreamController<bool> networkStreamController;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    networkStreamController = StreamController<bool>();

    when(
      () => mockNetworkInfo.isConnectedStream,
    ).thenAnswer((_) => networkStreamController.stream);

    bloc = ConnectivityBloc(networkInfo: mockNetworkInfo);
  });

  tearDown(() {
    networkStreamController.close();
    bloc.close();
  });

  test('initial state is correct', () {
    expect(
      bloc.state,
      const ConnectivityState(status: ConnectionStatus.initial),
    );
  });

  group('ConnectivityChanged', () {
    blocTest<ConnectivityBloc, ConnectivityState>(
      'emits [online] when network is connected',
      build: () => bloc,
      act: (bloc) => networkStreamController.add(true),
      expect: () => [const ConnectivityState(status: ConnectionStatus.online)],
    );

    blocTest<ConnectivityBloc, ConnectivityState>(
      'emits [offline] when network is disconnected',
      build: () => bloc,
      act: (bloc) => networkStreamController.add(false),
      expect: () => [const ConnectivityState(status: ConnectionStatus.offline)],
    );
  });
}
