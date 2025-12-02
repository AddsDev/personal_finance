import 'package:flutter/material.dart';

import '../extension/context_extensions.dart';

class TransactionListSection extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback? onViewAll;

  const TransactionListSection({
    super.key,
    required this.children,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Últimas Transacciones',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            if (onViewAll != null)
              TextButton(
                onPressed: onViewAll,
                child: const Text('Ver todo'),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color:  Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(8),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}