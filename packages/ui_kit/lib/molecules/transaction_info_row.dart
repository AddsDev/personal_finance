import 'package:flutter/material.dart';

import '../extension/context_extensions.dart';

class TransactionInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const TransactionInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.labelLarge?.copyWith(
            color: context.theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(value, style: context.textTheme.bodyLarge?.copyWith(fontSize: 18)),
      ],
    );
  }
}
