import '../entities/transaction.dart';
import '../entities/category.dart';

abstract class TransactionsRepository {
  Stream<List<TransactionEntity>> getTransactions({required String userId});

  /// Implements cache
  Future<List<Category>> getCategories();

  Future<void> addTransaction(TransactionEntity transaction);

  Future<void> updateTransaction(TransactionEntity transaction);

  Future<void> deleteTransaction({
    required String userId,
    required String transactionId,
  });
}
