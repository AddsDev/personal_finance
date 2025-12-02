import 'package:equatable/equatable.dart';

enum ConnectionStatus { initial, online, offline }

class ConnectivityState extends Equatable {
  final ConnectionStatus status;

  const ConnectivityState({this.status = ConnectionStatus.initial});

  bool get isOffline => status == ConnectionStatus.offline;

  @override
  List<Object> get props => [status];
}