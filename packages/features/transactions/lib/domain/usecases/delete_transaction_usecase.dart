import '../repositories/transactions_repository.dart';

class DeleteTransactionUseCase {
  final TransactionsRepository _repository;

  DeleteTransactionUseCase(this._repository);

  Future<void> call({
    required String userId,
    required String transactionId,
  }) async {
    return _repository.deleteTransaction(
      userId: userId,
      transactionId: transactionId,
    );
  }
}
