import 'package:flutter/material.dart';

import '../molecules/balance_card.dart';
import '../molecules/summary_card.dart';
import '../molecules/transaction_tile.dart';

class DashboardHeader extends StatelessWidget {
  final String balance;
  final String income;
  final String expense;

  const DashboardHeader({
    super.key,
    required this.balance,
    required this.income,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BalanceCard(title: 'Saldo Actual', balance: balance),
        const SizedBox(height: 16),
        Row(
          children: [
            SummaryCard(
              label: 'Ingresos',
              amount: income,
              type: TransactionType.income,
            ),
            const SizedBox(width: 16),
            SummaryCard(
              label: 'Gastos',
              amount: expense,
              type: TransactionType.expense,
            ),
          ],
        ),
      ],
    );
  }
}
