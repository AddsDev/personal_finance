import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/network_info.dart';
import 'connectivity_event.dart';
import 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final NetworkInfo _networkInfo;
  StreamSubscription<bool>? _subscription;

  ConnectivityBloc({
    required NetworkInfo networkInfo,
  })  : _networkInfo = networkInfo,
        super(const ConnectivityState()) {

    on<_ConnectivityChanged>(_onConnectivityChanged);

    _subscription = _networkInfo.isConnectedStream.listen((isConnected) {
      add(_ConnectivityChanged(isConnected));
    });
  }

  Future<void> _onConnectivityChanged(
      _ConnectivityChanged event,
      Emitter<ConnectivityState> emit,
      ) async {
    if (event.isConnected) {
      emit(const ConnectivityState(status: ConnectionStatus.online));

    } else {
      emit(const ConnectivityState(status: ConnectionStatus.offline));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

class _ConnectivityChanged extends ConnectivityEvent {
  final bool isConnected;
  const _ConnectivityChanged(this.isConnected);
}