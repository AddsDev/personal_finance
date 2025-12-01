import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/category.dart';
import '../models/category_model.dart';
import '../models/transaction_model.dart';

abstract class TransactionsRemoteDataSource {
  Stream<List<TransactionModel>> getTransactions(String userId);

  Future<List<CategoryModel>> getCategories();

  Future<void> addTransaction(TransactionModel transaction);

  Future<void> updateTransaction(TransactionModel transaction);

  Future<void> deleteTransaction(String userId, String transactionId);
}

class TransactionsRemoteDataSourceImpl implements TransactionsRemoteDataSource {
  final FirebaseFirestore _firestore;

  const TransactionsRemoteDataSourceImpl(this._firestore);

  @override
  Future<void> addTransaction(TransactionModel transaction) async {
    final userDoc = _firestore.collection('users').doc(transaction.userId);

    final transactionCollection = userDoc.collection('transactions');

    await transactionCollection.add(transaction.toJson());
  }

  @override
  Future<void> deleteTransaction(String userId, String transactionId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .doc(transactionId)
        .delete();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final snapshot = await _firestore.collection('categories').get();
    if (snapshot.docs.isEmpty) {
      return _defaultCategories();
    }

    return snapshot.docs
        .map((doc) => CategoryModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  @override
  Stream<List<TransactionModel>> getTransactions(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .orderBy('date', descending: true) // Order by date recent first
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => TransactionModel.fromFirestore(doc))
                  .toList(),
        );
  }

  Future<List<CategoryModel>> _defaultCategories() async {
    return [
      const CategoryModel(
        id: '1',
        name: 'Comida',
        iconKey: 'fastfood',
        colorValue: 0xFFEF4444,
        type: TransactionType.expense,
      ),
      const CategoryModel(
        id: '2',
        name: 'Salario',
        iconKey: 'work',
        colorValue: 0xFF10B981,
        type: TransactionType.income,
      ),
      const CategoryModel(
        id: '3',
        name: 'Transporte',
        iconKey: 'directions_car',
        colorValue: 0xFF3B82F6,
        type: TransactionType.expense,
      ),
    ];
  }

  @override
  Future<void> updateTransaction(TransactionModel transaction) async {
    if (transaction.id.isEmpty) {
      throw ArgumentError('Transaction id cannot be empty');
    }
    await _firestore
        .collection('users')
        .doc(transaction.userId)
        .collection('transactions')
        .doc(transaction.id)
        .update(transaction.toJson());
  }
}
