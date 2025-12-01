import 'package:equatable/equatable.dart';

import '../../domain/entities/transaction.dart';

enum TransactionsStatus { initial, loading, success, failure }

class TransactionState extends Equatable {
  final TransactionsStatus status;
  final List<TransactionEntity> transactions;
  final String? errorMessage;

  const TransactionState({
    this.status = TransactionsStatus.initial,
    this.transactions = const [],
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, transactions, errorMessage];
}
