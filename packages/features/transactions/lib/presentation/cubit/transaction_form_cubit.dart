import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/category.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/usecases/add_transaction_usecase.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/update_transaction_usecase.dart';
import 'transaction_form_status.dart';

class TransactionFormCubit extends Cubit<TransactionFormState> {
  final AddTransactionUseCase _addTransactionUseCase;
  final UpdateTransactionUseCase _updateTransactionUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  final TransactionEntity? _initialTransaction; // If exists is edit
  final String _userId;

  TransactionFormCubit({
    required AddTransactionUseCase addTransactionUseCase,
    required UpdateTransactionUseCase updateTransactionUseCase,
    required GetCategoriesUseCase getCategoriesUseCase,
    required String userId,
    TransactionEntity? transaction,
  }) : _addTransactionUseCase = addTransactionUseCase,
       _updateTransactionUseCase = updateTransactionUseCase,
       _getCategoriesUseCase = getCategoriesUseCase,
       _userId = userId,
       _initialTransaction = transaction,
       super(
         TransactionFormState(
           date: transaction?.date ?? DateTime.now(),
           amount: transaction?.amount ?? 0.0,
           description: transaction?.description ?? '',
           selectedCategory: transaction?.category,
           type: transaction?.type ?? TransactionType.expense,
         ),
       );

  Future<void> loadCategories() async {
    try {
      final categories = await _getCategoriesUseCase();
      emit(state.copyWith(availableCategories: categories));
    } catch (e) {
      emit(
        state.copyWith(
          status: TransactionFormStatus.failure,
          errorMessage: 'Error al cargar las categorías',
        ),
      );
    }
  }

  void amountChanged(double value) => emit(state.copyWith(amount: value));

  void descriptionChanged(String value) =>
      emit(state.copyWith(description: value));

  void categoryChanged(Category value) =>
      emit(state.copyWith(selectedCategory: value));

  void typeChanged(TransactionType value) => emit(state.copyWith(type: value));

  void dateChanged(DateTime value) => emit(state.copyWith(date: value));

  Future<void> submit() async {
    if (!state.isValid) return;

    emit(state.copyWith(status: TransactionFormStatus.loading));

    try {
      final transaction = TransactionEntity(
        id: _initialTransaction?.id ?? '', // If exists ID is edit
        amount: state.amount,
        description: state.description,
        date: state.date,
        category: state.selectedCategory!,
        userId: _userId,
        type: state.type,
      );

      if (_initialTransaction == null) {
        _addTransactionUseCase(transaction);
      } else {
        _updateTransactionUseCase(transaction);
      }

      emit(state.copyWith(status: TransactionFormStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: TransactionFormStatus.failure,
          errorMessage: 'Error al guardar la transacción',
        ),
      );
    }
  }
}
