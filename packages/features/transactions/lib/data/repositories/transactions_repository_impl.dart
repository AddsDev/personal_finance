import '../../domain/entities/category.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transactions_repository.dart';
import '../datasources/transactions_remote_data_source.dart';
import '../models/transaction_model.dart';

class TransactionsRepositoryImpl implements TransactionsRepository {
  final TransactionsRemoteDataSource _remoteDataSource;

  List<Category>? _categories;

  TransactionsRepositoryImpl(this._remoteDataSource);

  //TODO: Implementar invalidar cache
  void invalidateCache() {
    _categories = null;
  }

  @override
  Future<void> addTransaction(TransactionEntity transaction) async {
    final model = TransactionModel.fromEntity(transaction);
    await _remoteDataSource.addTransaction(model);
  }

  @override
  Future<void> deleteTransaction({
    required String userId,
    required String transactionId,
  }) async {
    await _remoteDataSource.deleteTransaction(userId, transactionId);
  }

  @override
  Future<List<Category>> getCategories() async {
    if (_categories != null && _categories!.isNotEmpty) {
      return _categories!;
    }

    final result = await _remoteDataSource.getCategories();
    _categories = result;
    return result;
  }

  @override
  Stream<List<TransactionEntity>> getTransactions({required String userId}) {
    return _remoteDataSource.getTransactions(userId);
  }

  @override
  Future<void> updateTransaction(TransactionEntity transaction) async {
    final model = TransactionModel.fromEntity(transaction);
    await _remoteDataSource.updateTransaction(model);
  }
}
