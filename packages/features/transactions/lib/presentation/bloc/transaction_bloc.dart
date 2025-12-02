import 'dart:async';

import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transactions_repository.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _TransactionsListUpdated extends TransactionsEvent {
  final List<TransactionEntity> transactions;

  const _TransactionsListUpdated(this.transactions);
}

class TransactionBloc extends Bloc<TransactionsEvent, TransactionState> {
  final TransactionsRepository _repository;
  StreamSubscription<List<TransactionEntity>>? _transactionsSubscription;

  TransactionBloc({required TransactionsRepository repository})
    : _repository = repository,
      super(const TransactionState()) {
    on<TransactionsSubscriptionRequested>(_onSubscriptionRequested);
    on<_TransactionsListUpdated>(_onListUpdated);
    on<TransactionDeleteRequested>(_onDeleteRequested);
  }

  FutureOr<void> _onSubscriptionRequested(
    TransactionsSubscriptionRequested event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionState(status: TransactionsStatus.loading));
    await _transactionsSubscription?.cancel();
    _transactionsSubscription = _repository
        .getTransactions(userId: event.userId)
        .listen(
          (transactions) => add(_TransactionsListUpdated(transactions)),
          //TODO: handle error
          onError: (error) => add(const _TransactionsListUpdated([])),
        );
  }

  FutureOr<void> _onListUpdated(
    _TransactionsListUpdated event,
    Emitter<TransactionState> emit,
  ) {
    emit(
      TransactionState(
        status: TransactionsStatus.success,
        transactions: event.transactions,
      ),
    );
  }

  FutureOr<void> _onDeleteRequested(
    TransactionDeleteRequested event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionState(status: TransactionsStatus.loading));
    try {
      await _repository.deleteTransaction(
        userId: event.userId,
        transactionId: event.transactionId,
      );
    } catch (e) {
      emit(
        const TransactionState(
          status: TransactionsStatus.failure,
          errorMessage: 'Error deleting transaction',
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _transactionsSubscription?.cancel();
    return super.close();
  }
}
