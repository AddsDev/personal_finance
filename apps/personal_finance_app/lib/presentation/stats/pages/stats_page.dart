import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:transactions/domain/repositories/transactions_repository.dart';
import 'package:transactions/transactions.dart';
import 'package:ui_kit/ui_kit.dart';
import '../bloc/stats_bloc.dart';
import '../bloc/stats_event.dart';
import '../bloc/stats_state.dart';

class StatsPage extends StatelessWidget {
  final String userId;

  const StatsPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              StatsBloc(repository: GetIt.instance<TransactionsRepository>())
                ..add(StatsSubscriptionRequested(userId)),
      child: const _StatsView(),
    );
  }
}

class _StatsView extends StatelessWidget {
  const _StatsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu día a día'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<StatsBloc, StatsState>(
        builder: (context, state) {
          if (state.status == StatsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.transactions.isEmpty) {
            return const Center(child: Text('No hay datos para mostrar'));
          }

          // Filter date
          final filteredTransactions =
              state.transactions.where((tx) {
                return tx.date.year == state.filterDate.year &&
                    tx.date.month == state.filterDate.month;
              }).toList();

          final expenses =
              filteredTransactions.where((tx) => tx.isExpense).toList();
          //TODO: Hacer igual para el income

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildDateSelector(context, state.filterDate),
                const SizedBox(height: 24),
                //TODO: pasar a Atomic
                _buildChartSection(context, 'Gastos', expenses, true),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context, DateTime date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            context.read<StatsBloc>().add(
              StatsDateChanged(DateTime(date.year, date.month - 1)),
            );
          },
        ),
        Text(
          DateFormat.yMMMM().format(date),
          style: context.textTheme.titleLarge,
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () {
            context.read<StatsBloc>().add(
              StatsDateChanged(DateTime(date.year, date.month + 1)),
            );
          },
        ),
      ],
    );
  }

  Widget _buildChartSection(
    BuildContext context,
    String title,
    List<TransactionEntity> transactions,
    bool isExpense,
  ) {
    if (transactions.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(title, style: context.textTheme.titleMedium),
              const SizedBox(height: 16),
              const Text('Sin datos en este periodo'),
            ],
          ),
        ),
      );
    }

    final total = transactions.fold(0.0, (sum, tx) => sum + tx.amount);
    final byCategory = <String, double>{};
    for (final tx in transactions) {
      byCategory.update(
        tx.category.name,
        (value) => value + tx.amount,
        ifAbsent: () => tx.amount,
      );
    }

    final sections =
        byCategory.entries.map((entry) {
          final percentage = entry.value / total;
          final percentText = (percentage * 100).toStringAsFixed(0);

          return PieChartSectionData(
            color:
                Colors.primaries[entry.key.hashCode % Colors.primaries.length],
            value: entry.value,
            title: '$percentText%',
            radius: 50,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }).toList();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(title, style: context.textTheme.titleMedium),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: sections,
                  centerSpaceRadius: 40,
                  sectionsSpace: 2,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Column(
              children:
                  byCategory.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color:
                                      Colors.primaries[entry.key.hashCode %
                                          Colors.primaries.length],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(entry.key),
                            ],
                          ),
                          Text(
                            CurrencyHelper.format(entry.value),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  isExpense
                                      ? context.appColors.expense
                                      : context.appColors.income,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
