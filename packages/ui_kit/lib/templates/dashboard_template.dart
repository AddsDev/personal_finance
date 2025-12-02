import 'package:flutter/material.dart';

class DashboardTemplate extends StatelessWidget {
  final Widget header;
  final Widget content;
  final VoidCallback? onAddTransaction;
  final String? userName;
  final VoidCallback? onActionTap;
  final List<Widget>? actions;

  const DashboardTemplate({
    super.key,
    required this.header,
    required this.content,
    this.onAddTransaction,
    this.userName,
    this.onActionTap,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard de',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontSize: 14),
            ),
            Text(
              userName ?? 'Finanzas',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions:
            actions ??
            [
              if (onActionTap != null)
                IconButton(
                  onPressed: onActionTap,
                  icon: const CircleAvatar(child: Icon(Icons.logout)),
                ),
              const SizedBox(width: 16),
            ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh logic
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: [
              header,
              const SizedBox(height: 32),
              content,
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton:
          onAddTransaction != null
              ? FloatingActionButton(
                onPressed: onAddTransaction,
                child: const Icon(Icons.add),
              )
              : null,
    );
  }
}
