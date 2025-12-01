import 'package:cloud_firestore/cloud_firestore.dart';

import '../../transactions.dart';
import 'category_model.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required super.id,
    required super.amount,
    required super.description,
    required super.date,
    required super.category,
    required super.userId,
    required super.type,
  });

  factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    //Convert datetime
    final timestamp = data['date'] as Timestamp;

    // Convert category
    final categoryModel = CategoryModel(
      id: data['categoryId'] as String,
      name: data['categoryName'] as String,
      iconKey: data['categoryIcon'] as String,
      colorValue: data['categoryColor'] as int,
      type: TransactionType.values.firstWhere(
        (e) => e.name == data['type'],
        orElse: () => TransactionType.expense,
      ),
    );

    return TransactionModel(
      id: doc.id,
      amount: (data['amount'] as num).toDouble(),
      description: data['description'] as String,
      date: timestamp.toDate(),
      category: categoryModel,
      userId: data['userId'] as String,
      type: TransactionType.values.firstWhere(
        (e) => e.name == data['type'],
        orElse: () => TransactionType.expense,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'description': description,
      'date': Timestamp.fromDate(date),
      'userId': userId,
      'type': type.name,
      // Category
      'categoryId': category.id,
      'categoryName': category.name,
      'categoryIcon': category.iconKey,
      'categoryColor': category.colorValue,
    };
  }

  factory TransactionModel.fromEntity(TransactionEntity entity) {
    return TransactionModel(
      id: entity.id,
      amount: entity.amount,
      description: entity.description,
      date: entity.date,
      category: entity.category,
      userId: entity.userId,
      type: entity.type,
    );
  }
}
