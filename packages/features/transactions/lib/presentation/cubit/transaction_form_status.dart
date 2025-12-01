import 'package:equatable/equatable.dart';

import '../../domain/entities/category.dart';

enum TransactionFormStatus { initial, loading, success, failure }

class TransactionFormState extends Equatable {
  final TransactionFormStatus status;
  final String? errorMessage;

  // Form fields
  final double amount;
  final String description;
  final Category? selectedCategory;
  final TransactionType type;
  final DateTime date;

  // Available categories
  final List<Category> availableCategories;

  const TransactionFormState({
    this.status = TransactionFormStatus.initial,
    this.errorMessage,
    this.amount = 0.0,
    this.description = '',
    this.selectedCategory,
    this.type = TransactionType.expense,
    required this.date,
    this.availableCategories = const [],
  });

  bool get isValid =>
      amount > 0 && description.isNotEmpty && selectedCategory != null;

  TransactionFormState copyWith({
    TransactionFormStatus? status,
    String? errorMessage,
    double? amount,
    String? description,
    Category? selectedCategory,
    TransactionType? type,
    DateTime? date,
    List<Category>? availableCategories,
  }) {
    return TransactionFormState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      type: type ?? this.type,
      date: date ?? this.date,
      availableCategories: availableCategories ?? this.availableCategories,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    amount,
    description,
    selectedCategory,
    type,
    date,
    availableCategories,
  ];
}
