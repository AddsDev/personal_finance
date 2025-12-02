import 'package:equatable/equatable.dart';

enum TransactionDetailStatus { initial, loading, success, failure }

class TransactionDetailState extends Equatable {
  final TransactionDetailStatus status;
  final String? errorMessage;

  const TransactionDetailState({
    this.status = TransactionDetailStatus.initial,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, errorMessage];

  TransactionDetailState copyWith({
    TransactionDetailStatus? status,
    String? errorMessage,
  }) {
    return TransactionDetailState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
