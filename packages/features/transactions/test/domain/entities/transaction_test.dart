import 'package:flutter_test/flutter_test.dart';
import 'package:transactions/domain/entities/category.dart';
import 'package:transactions/domain/entities/transaction.dart';

void main() {
  const tCategory = Category(
    id: '1',
    name: 'Cat',
    iconKey: 'icon',
    colorValue: 0,
    type: TransactionType.expense,
  );

  test('isIncome return true only for income type', () {
    final tTransactionIncome = TransactionEntity(
      id: '1',
      amount: 10,
      description: 'd',
      date: DateTime(2022),
      category: tCategory,
      userId: 'u1',
      type: TransactionType.income,
    );

    expect(tTransactionIncome.isIncome, true);
    expect(tTransactionIncome.isExpense, false);
  });

  test('isExpense return true only for expense type', () {
    final tTransactionExpense = TransactionEntity(
      id: '1',
      amount: 10,
      description: 'd',
      date: DateTime(2022),
      category: tCategory,
      userId: 'u1',
      type: TransactionType.expense,
    );

    expect(tTransactionExpense.isExpense, true);
    expect(tTransactionExpense.isIncome, false);
  });
}
