import 'package:flutter/material.dart';

import '../extension/context_extensions.dart';
import '../extension/icon_extensions.dart';

class TransactionDetailHeader extends StatelessWidget {
  final String categoryName;
  final String categoryIconKey;
  final String formattedAmount;
  final Color color;

  const TransactionDetailHeader({
    super.key,
    required this.categoryName,
    required this.categoryIconKey,
    required this.formattedAmount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withAlpha(22),
              shape: BoxShape.circle,
            ),
            child: Icon(
              context.mapIconData(categoryIconKey),
              size: 48,
              color: color,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            categoryName,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            formattedAmount,
            style: context.textTheme.displayMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
