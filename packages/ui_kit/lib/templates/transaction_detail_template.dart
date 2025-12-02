import 'package:flutter/material.dart';

import '../atoms/app_round_button.dart';
import '../extension/context_extensions.dart';

class TransactionDetailTemplate extends StatelessWidget {
  final Widget header;
  final List<Widget> details;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TransactionDetailTemplate({
    super.key,
    required this.header,
    required this.details,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalle',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          AppRoundButton(
            onPressed: onDelete,
            iconData: Icons.delete,
            foregroundColor: Colors.white,
            backgroundColor: context.appColors.expense,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header,
            const SizedBox(height: 40),
            const Divider(height: 32),
            ...details,
            const Divider(height: 32),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onEdit,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
