import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transactions/domain/entities/category.dart' as category_entity;
import 'package:transactions/domain/entities/transaction.dart';
import 'package:transactions/domain/entities/transaction_summary_extension.dart';
import 'package:transactions/presentation/bloc/transaction_bloc.dart';
import 'package:transactions/presentation/bloc/transaction_event.dart';
import 'package:transactions/presentation/bloc/transaction_state.dart';
import 'package:ui_kit/ui_kit.dart';

class DashboardPage extends StatefulWidget {
  final Function(String) onAddTransactionTap;

  const DashboardPage({super.key, required this.onAddTransactionTap});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = context.read<AuthBloc>().state.user.id;
      context.read<TransactionBloc>().add(
        TransactionsSubscriptionRequested(userId),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc bloc) => bloc.state.user);
    final isWebOrLargeTablet = MediaQuery.sizeOf(context).width > 900;

    return DashboardTemplate(
      userName: user.name ?? 'Usuario',
      onActionTap: () => _showLogoutDialog(context),
      onAddTransaction: () => widget.onAddTransactionTap(user.id),
      header: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          final balance = state.transactions.currentBalance;
          final income = state.transactions.incomeForMonth(DateTime.now());
          final expense = state.transactions.expenseForMonth(DateTime.now());
          if (state.status == TransactionsStatus.loading &&
              state.transactions.isEmpty) {
            //TODO: Loading or Shimmer
            return const Center(child: CircularProgressIndicator());
          }
          return DashboardHeader(
            balance: CurrencyHelper.format(balance),
            income: CurrencyHelper.format(income),
            expense: CurrencyHelper.format(expense),
          );
        },
      ),
      content: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state.status == TransactionsStatus.loading &&
              state.transactions.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state.transactions.isEmpty) {
            return _buildEmptyState(context);
          }
          final lastTransactions = state.transactions.lastTransactions(
            limit: 10,
          );
          if (isWebOrLargeTablet) {
            return _buildWebGridContent(context, lastTransactions);
          }
          return _buildMobileListContent(context, lastTransactions);
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Cerrar Sesión'),
            content: const Text('¿Estás seguro de que deseas salir?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  context.read<AuthBloc>().add(AuthLogoutRequested());
                },
                child: const Text('Salir', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }
}

Widget _buildEmptyState(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Icon(
            Icons.savings_outlined,
            size: 60,
            color: context.theme.disabledColor,
          ),
          const SizedBox(height: 16),
          Text(
            'No tienes movimientos aún',
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.theme.disabledColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Añade tu primer gasto o ingreso',
            style: context.textTheme.bodySmall,
          ),
        ],
      ),
    ),
  );
}

Widget _buildWebGridContent(
  BuildContext context,
  List<TransactionEntity> transactions,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Últimas Transacciones',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ver todas las transacciones')),
              );
            },
            child: const Text('Ver todo'),
          ),
        ],
      ),
      const SizedBox(height: 16),
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400, // Card Size
          mainAxisExtent: 80, //  Card Height
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final tx = transactions[index];
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).dividerColor.withAlpha(16),
              ),
            ),
            child: Center(child: _transactionTile(context, tx)),
          );
        },
      ),
    ],
  );
}

Widget _transactionTile(BuildContext context, TransactionEntity tx) {
  return TransactionTile(
    title: tx.description,
    subtitle: _formatDate(tx.date),
    amount: CurrencyHelper.formatWithSign(tx.amount, isExpense: tx.isExpense),
    type:
        tx.type == category_entity.TransactionType.income
            ? TransactionType.income
            : TransactionType.expense,
    icon: _mapIcon(tx.category.iconKey),
    onTap: () => context.push('/edit-transaction', extra: tx),
  );
}

String _formatDate(DateTime date) {
  return "${date.day}/${date.month}";
}

IconData _mapIcon(String key) {
  switch (key) {
    case 'fastfood':
      return Icons.fastfood;
    case 'work':
      return Icons.work;
    case 'directions_car':
      return Icons.directions_car;
    case 'home':
      return Icons.home;
    case 'shopping_cart':
      return Icons.shopping_cart;
    case 'movie':
      return Icons.movie;
    case 'health_and_safety':
      return Icons.health_and_safety;
    default:
      return Icons.category;
  }
}

Widget _buildMobileListContent(
  BuildContext context,
  List<TransactionEntity> transactions,
) {
  return TransactionListSection(
    onViewAll: () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ver todas las transacciones')),
      );
    },
    children:
        transactions.map((tx) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: _transactionTile(context, tx),
          );
        }).toList(),
  );
}
