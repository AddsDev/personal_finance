import 'package:equatable/equatable.dart';
import 'category.dart';

class TransactionEntity extends Equatable {
  final String id;
  final double amount;
  final String description;
  final DateTime date;
  final Category category; // Snapshot category
  final String userId;
  final TransactionType type;

  const TransactionEntity({
    required this.id,
    required this.amount,
    required this.description,
    required this.date,
    required this.category,
    required this.userId,
    required this.type,
  });

  bool get isIncome => type == TransactionType.income;

  bool get isExpense => type == TransactionType.expense;

  @override
  List<Object?> get props => [
    id,
    amount,
    description,
    date,
    category,
    userId,
    type,
  ];
}
