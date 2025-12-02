import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:ui_kit/ui_kit.dart' hide TransactionType;
import '../../../domain/entities/transaction.dart';
import '../../../domain/entities/category.dart';
import '../cubit/transaction_form_cubit.dart';
import '../cubit/transaction_form_status.dart';
import '../widgets/category_selector.dart';

import '../../../domain/usecases/add_transaction_usecase.dart';
import '../../../domain/usecases/update_transaction_usecase.dart';
import '../../../domain/usecases/get_categories_usecase.dart';

class TransactionFormPage extends StatelessWidget {
  final String userId;
  final TransactionEntity? transactionToEdit;

  const TransactionFormPage({
    super.key,
    this.transactionToEdit,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final it = GetIt.instance;

    return BlocProvider(
      create:
          (context) => TransactionFormCubit(
            addTransactionUseCase: it<AddTransactionUseCase>(),
            updateTransactionUseCase: it<UpdateTransactionUseCase>(),
            getCategoriesUseCase: it<GetCategoriesUseCase>(),
            userId: userId,
            transaction: transactionToEdit,
          )..loadCategories(),
      child: const _TransactionFormView(),
    );
  }
}

class _TransactionFormView extends StatefulWidget {
  const _TransactionFormView();

  @override
  State<_TransactionFormView> createState() => _TransactionFormViewState();
}

class _TransactionFormViewState extends State<_TransactionFormView> {
  final _amountController = TextEditingController();
  final _calendarController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<TransactionFormCubit>().state;
    if (state.amount > 0) {
      _amountController.text = state.amount.toStringAsFixed(0);
    }
    _descController.text = state.description;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionFormCubit, TransactionFormState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == TransactionFormStatus.success) {
          context.pop(); // Go to dashboard
        } else if (state.status == TransactionFormStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Error desconocido')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.read<TransactionFormCubit>().state.amount == 0
                ? 'Nueva Transacción'
                : 'Editar Transacción',
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => context.pop(),
            color: context.theme.iconTheme.color,
          ),
        ),
        body: BlocBuilder<TransactionFormCubit, TransactionFormState>(
          builder: (context, state) {
            if (state.status == TransactionFormStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            final isExpense = state.type == TransactionType.expense;
            final color =
                isExpense
                    ? context.appColors.expense
                    : context.appColors.income;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTypeSelector(context, state.type),
                  const SizedBox(height: 32),

                  Text('Monto', style: context.textTheme.labelLarge),
                  TextField(
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: false,
                      signed: false,
                    ),
                    style: context.textTheme.displaySmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      prefixText: isExpense ? '- \$' : '+ \$',
                      prefixStyle: context.textTheme.displaySmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: '0',
                      hintStyle: context.textTheme.displaySmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 10,
                    onChanged: (value) {
                      final amount = double.tryParse(value) ?? 0.0;
                      context.read<TransactionFormCubit>().amountChanged(
                        amount,
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  Text('Categoría', style: context.textTheme.titleMedium),
                  const SizedBox(height: 16),
                  CategorySelector(
                    categories:
                        state.availableCategories
                            .where((c) => c.type == state.type)
                            .toList(),
                    selectedCategory: state.selectedCategory,
                    onSelected: (category) {
                      context.read<TransactionFormCubit>().categoryChanged(
                        category,
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  AppInput(
                    label: 'Descripción',
                    hint: 'Salchipapa, Moto, Coca-Cola....',
                    controller: _descController,
                    onChanged:
                        (value) => context
                            .read<TransactionFormCubit>()
                            .descriptionChanged(value),
                  ),
                  const SizedBox(height: 16),

                  AppInput(
                    label: 'Fecha',
                    hint: DateFormat.yMMMd().format(DateTime.now()),
                    controller: _calendarController,
                    prefixIcon: Icons.calendar_today,
                    readOnly: true,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: state.date,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (date != null && context.mounted) {
                        _calendarController.text = DateFormat.yMMMd().format(
                          date,
                        );
                        context.read<TransactionFormCubit>().dateChanged(date);
                      }
                    },
                  ),

                  const SizedBox(height: 40),

                  AppButton(
                    text: 'Guardar Transacción',
                    isLoading: state.status == TransactionFormStatus.loading,
                    onPressed:
                        state.isValid
                            ? () =>
                                context.read<TransactionFormCubit>().submit()
                            : null,
                    type: AppButtonType.primary,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTypeSelector(BuildContext context, TransactionType currentType) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          _buildTypeButton(
            context,
            'Gasto',
            TransactionType.expense,
            currentType == TransactionType.expense,
          ),
          _buildTypeButton(
            context,
            'Ingreso',
            TransactionType.income,
            currentType == TransactionType.income,
          ),
        ],
      ),
    );
  }

  Widget _buildTypeButton(
    BuildContext context,
    String text,
    TransactionType type,
    bool isSelected,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.read<TransactionFormCubit>().typeChanged(type);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color:
                isSelected
                    ? context.theme.scaffoldBackgroundColor
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow:
                isSelected
                    ? [
                      BoxShadow(
                        color: Colors.black.withAlpha(77),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]
                    : null,
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color:
                  isSelected
                      ? (type == TransactionType.expense
                          ? context.appColors.expense
                          : context.appColors.income)
                      : context.theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
