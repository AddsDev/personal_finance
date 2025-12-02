import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ui_kit/ui_kit.dart' hide TransactionType;
import '../../../domain/entities/transaction.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/usecases/delete_transaction_usecase.dart';
import '../cubit/transaction_detail_cubit.dart';
import '../cubit/transaction_detail_state.dart';

class TransactionDetailPage extends StatelessWidget {
  final Function(TransactionEntity transactionToEdit) onEditTransaction;
  final TransactionEntity transaction;

  const TransactionDetailPage({
    super.key,
    required this.transaction,
    required this.onEditTransaction,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        transaction.type == TransactionType.expense
            ? context.appColors.expense
            : context.appColors.income;
    return BlocProvider(
      create:
          (context) => TransactionDetailCubit(
            deleteTransactionUseCase:
                GetIt.instance<DeleteTransactionUseCase>(),
          ),
      child: BlocConsumer<TransactionDetailCubit, TransactionDetailState>(
        listener: (context, state) {
          if (state.status == TransactionDetailStatus.success) {
            context.pop();
          }
        },
        builder:
            (context, state) => TransactionDetailTemplate(
              header: TransactionDetailHeader(
                categoryName: transaction.category.name,
                categoryIconKey: transaction.category.iconKey,
                formattedAmount: CurrencyHelper.formatWithSign(
                  transaction.amount,
                  isExpense: transaction.isExpense,
                ),
                color: color,
              ),
              details: [
                TransactionInfoRow(
                  label: 'Descripción',
                  value: transaction.description,
                ),
                const SizedBox(height: 20),
                TransactionInfoRow(
                  label: 'Fecha',
                  value: DateFormat.yMMMd().format(transaction.date),
                ),
                const SizedBox(height: 20),
                TransactionInfoRow(
                  label: 'Tipo',
                  value:
                  transaction.type == TransactionType.expense
                      ? 'Gasto'
                      : 'Ingreso',
                ),
              ],
              onDelete: () => _showDeleteConfirmation(context),
              onEdit: () => onEditTransaction(transaction),
            ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    final cubit = context.read<TransactionDetailCubit>();
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Eliminar Transacción'),
          content: const Text(
            '¿Estás seguro de que deseas eliminar esta transacción?',
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                context.pop();
                cubit.deleteTransaction(transaction.id, transaction.userId);
              },
              child: const Text(
                'Eliminar',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
