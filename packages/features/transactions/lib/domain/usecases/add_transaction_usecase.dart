import 'package:core/errors/failure.dart';

import '../entities/transaction.dart';
import '../repositories/transactions_repository.dart';

class AddTransactionUseCase {
  final TransactionsRepository _repository;
  AddTransactionUseCase(this._repository);

  Future<void> call(TransactionEntity transaction) async {
    return _repository.addTransaction(transaction);
  }
}