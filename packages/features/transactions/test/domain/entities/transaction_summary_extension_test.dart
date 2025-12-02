import 'package:flutter_test/flutter_test.dart';
import 'package:transactions/domain/entities/category.dart';
import 'package:transactions/domain/entities/transaction.dart';
import 'package:transactions/domain/entities/transaction_summary_extension.dart';

void main() {
  const categoryExpense = Category(
    id: '1',
    name: 'Food',
    iconKey: 'food',
    colorValue: 0,
    type: TransactionType.expense,
  );
  const categoryIncome = Category(
    id: '2',
    name: 'Salary',
    iconKey: 'work',
    colorValue: 0,
    type: TransactionType.income,
  );

  final transactions = [
    TransactionEntity(
      id: '1',
      amount: 100,
      description: 'Breakfast',
      date: DateTime(2023, 10, 1),
      category: categoryExpense,
      userId: 'u1',
      type: TransactionType.expense,
    ),
    TransactionEntity(
      id: '2',
      amount: 2000,
      description: 'Salary',
      date: DateTime(2023, 10, 15),
      category: categoryIncome,
      userId: 'u1',
      type: TransactionType.income,
    ),
    TransactionEntity(
      id: '3',
      amount: 50,
      description: 'Taxi',
      date: DateTime(2023, 11, 1),
      category: categoryExpense,
      userId: 'u1',
      type: TransactionType.expense,
    ),
  ];

  group('TransactionSummaryExtension', () {
    test('currentBalance should calculate total balance correctly', () {
      // 2000 I - 100 E - 50 E = 1850
      expect(transactions.currentBalance, 1850.0);
    });

    test(
      'expenseForMonth should return sum of expenses for specific month',
      () {
        final date = DateTime(2023, 10, 1);
        // Solo son 100 por Octubre
        expect(transactions.expenseForMonth(date), 100.0);
      },
    );

    test('incomeForMonth should return sum of income for specific month', () {
      final date = DateTime(2023, 10, 1);
      expect(transactions.incomeForMonth(date), 2000.0);
    });
  });
}
