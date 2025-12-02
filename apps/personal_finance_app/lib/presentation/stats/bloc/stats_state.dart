import 'package:equatable/equatable.dart';
import 'package:transactions/transactions.dart';

enum StatsStatus { initial, loading, success, failure }

class StatsState extends Equatable {
  final StatsStatus status;
  final List<TransactionEntity> transactions;
  final DateTime filterDate;
  final String? errorMessage;

  const StatsState({
    this.status = StatsStatus.initial,
    this.transactions = const [],
    required this.filterDate,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, transactions, filterDate, errorMessage];

  StatsState copyWith({
    StatsStatus? status,
    List<TransactionEntity>? transactions,
    DateTime? filterDate,
    String? errorMessage,
  }) {
    return StatsState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      filterDate: filterDate ?? this.filterDate,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
