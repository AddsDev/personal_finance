import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_app/presentation/stats/bloc/stats_event.dart';
import 'package:personal_finance_app/presentation/stats/bloc/stats_state.dart';
import 'package:transactions/domain/repositories/transactions_repository.dart';
import 'package:transactions/transactions.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final TransactionsRepository _repository;
  StreamSubscription<List<TransactionEntity>>? _subscription;

  StatsBloc({required TransactionsRepository repository})
    : _repository = repository,
      super(StatsState(filterDate: DateTime.now())) {
    on<StatsSubscriptionRequested>(_onSubscriptionRequested);
    on<StatsDateChanged>(_onDateChanged);
    on<_StatsUpdated>(_onStatsUpdated);
    on<_StatsError>(_onStatsError);
  }

  Future<void> _onSubscriptionRequested(
    StatsSubscriptionRequested event,
    Emitter<StatsState> emit,
  ) async {
    emit(state.copyWith(status: StatsStatus.loading));

    await _subscription?.cancel();
    _subscription = _repository
        .getTransactions(userId: event.userId)
        .listen(
          (transactions) {
            add(_StatsUpdated(transactions));
          },
          onError: (error) {
            add(_StatsError(error.toString()));
          },
        );
  }

  void _onDateChanged(StatsDateChanged event, Emitter<StatsState> emit) {
    emit(state.copyWith(filterDate: event.date));
  }

  Future<void> _onStatsUpdated(
    _StatsUpdated event,
    Emitter<StatsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: StatsStatus.success,
        transactions: event.transactions,
      ),
    );
  }

  void _onStatsError(_StatsError event, Emitter<StatsState> emit) {
    emit(
      state.copyWith(status: StatsStatus.failure, errorMessage: event.message),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

// Events
class _StatsUpdated extends StatsEvent {
  final List<TransactionEntity> transactions;

  const _StatsUpdated(this.transactions);
}

class _StatsError extends StatsEvent {
  final String message;

  const _StatsError(this.message);
}
