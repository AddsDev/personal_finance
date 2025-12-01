import 'package:equatable/equatable.dart';

abstract class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object> get props => [];
}

class TransactionsSubscriptionRequested extends TransactionsEvent {
  final String userId;

  const TransactionsSubscriptionRequested(this.userId);
}

class TransactionDeleteRequested extends TransactionsEvent {
  final String userId;
  final String transactionId;

  const TransactionDeleteRequested({
    required this.userId,
    required this.transactionId,
  });
}
