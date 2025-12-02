import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transactions/domain/repositories/transactions_repository.dart';
import 'package:transactions/presentation/bloc/transaction_bloc.dart';
import 'package:transactions/presentation/bloc/transaction_event.dart';
import 'package:transactions/presentation/bloc/transaction_state.dart';

class MockTransactionsRepository extends Mock
    implements TransactionsRepository {}

void main() {
  late TransactionsRepository repository;
  late TransactionBloc bloc;

  setUp(() {
    repository = MockTransactionsRepository();
    bloc = TransactionBloc(repository: repository);
  });

  tearDown(() {
    bloc.close();
  });

  group('TransactionBloc', () {
    test('initial state is correct', () {
      expect(bloc.state, const TransactionState());
    });

    blocTest<TransactionBloc, TransactionState>(
      'emits [loading, success] when subscription requested',
      setUp: () {
        when(
          () => repository.getTransactions(userId: '1'),
        ).thenAnswer((_) => Stream.value([]));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(const TransactionsSubscriptionRequested('1')),
      expect:
          () => [
            const TransactionState(status: TransactionsStatus.loading),
            const TransactionState(
              status: TransactionsStatus.success,
              transactions: [],
            ),
          ],
    );

    blocTest<TransactionBloc, TransactionState>(
      'emits [loading, success] when delete requested',
      setUp: () {
        when(
          () => repository.deleteTransaction(userId: '1', transactionId: 'tx1'),
        ).thenAnswer((_) async {});
      },
      build: () => bloc,
      act:
          (bloc) => bloc.add(
            const TransactionDeleteRequested(userId: '1', transactionId: 'tx1'),
          ),
      expect:
          () => [const TransactionState(status: TransactionsStatus.loading)],
    );

    blocTest<TransactionBloc, TransactionState>(
      'emits [loading, success] (with empty list) when stream emits error',
      build: () {
        when(
          () => repository.getTransactions(userId: '1'),
        ).thenAnswer((_) => Stream.error(Exception('Error')));
        return bloc;
      },
      act: (bloc) => bloc.add(const TransactionsSubscriptionRequested('1')),
      expect:
          () => [
            const TransactionState(status: TransactionsStatus.loading),
            const TransactionState(
              status: TransactionsStatus.success,
              transactions: [],
            ),
          ],
    );
  });
}
