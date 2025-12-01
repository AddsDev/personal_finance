import 'category.dart';
import 'transaction.dart';

extension TransactionSummary on List<TransactionEntity> {
  double get currentBalance {
    return fold(0, (balance, transaction) {
      if (transaction.type == TransactionType.income) {
        return balance + transaction.amount;
      } else {
        return balance - transaction.amount;
      }
    });
  }

  double incomeForMonth(DateTime date) {
    return where(
      (transaction) =>
          transaction.type == TransactionType.income &&
          transaction.date.year == date.year &&
          transaction.date.month == date.month,
    ).fold(0, (sum, transaction) => sum + transaction.amount);
  }

  double expenseForMonth(DateTime date) {
    return where(
      (transaction) =>
          transaction.type == TransactionType.expense &&
          transaction.date.year == date.year &&
          transaction.date.month == date.month,
    ).fold(0, (sum, transaction) => sum + transaction.amount);
  }

  List<TransactionEntity> lastTransactions({int limit = 10}) {
    return take(limit).toList();
  }
}
