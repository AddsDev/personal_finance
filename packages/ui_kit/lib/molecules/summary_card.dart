import 'package:flutter/material.dart';
import '../extension/context_extensions.dart';
import 'transaction_tile.dart';

class SummaryCard extends StatelessWidget {
  final String label;
  final String amount;
  final TransactionType type;

  const SummaryCard({
    super.key,
    required this.label,
    required this.amount,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = type == TransactionType.income;
    final icon = isIncome ? Icons.arrow_upward : Icons.arrow_downward;
    final iconColor =
        isIncome ? context.appColors.income : context.appColors.expense;

    final bgColor =
        context.theme.brightness == Brightness.dark
            ? context.theme.colorScheme.surfaceContainerLow
            : Colors.white;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(26),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              amount,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
