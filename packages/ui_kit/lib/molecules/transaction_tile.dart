import 'package:flutter/material.dart';
import '../extension/context_extensions.dart';

enum TransactionType { income, expense }

class TransactionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount; // With format example income "- $85.50"
  final TransactionType type;
  final IconData icon;
  final VoidCallback? onTap;

  const TransactionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.type,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = type == TransactionType.income;
    final amountColor =
        isIncome
            ? context.appColors.income
            : context.theme.colorScheme.onSurface;

    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: context.theme.colorScheme.surfaceContainerHighest.withAlpha(
            128,
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: context.theme.colorScheme.primary, size: 20),
      ),
      title: Text(
        title,
        style: context.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: context.textTheme.bodySmall?.copyWith(
          color: context.theme.colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Text(
          amount,
          style: context.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: amountColor,
          ),
        ),
      ),
    );
  }
}
