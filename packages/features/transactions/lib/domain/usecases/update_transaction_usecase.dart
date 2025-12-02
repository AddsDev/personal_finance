import '../entities/transaction.dart';
import '../repositories/transactions_repository.dart';

class UpdateTransactionUseCase {
  final TransactionsRepository _repository;

  UpdateTransactionUseCase(this._repository);

  Future<void> call(TransactionEntity transaction) async {
    return _repository.updateTransaction(transaction);
  }
}
