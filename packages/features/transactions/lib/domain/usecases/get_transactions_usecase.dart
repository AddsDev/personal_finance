import '../entities/transaction.dart';
import '../repositories/transactions_repository.dart';

class GetTransactionsUseCase {
  final TransactionsRepository _repository;
  GetTransactionsUseCase(this._repository);

  Stream<List<TransactionEntity>> call({required String userId}) {
    return _repository.getTransactions(userId: userId);
  }
}