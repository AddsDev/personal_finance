import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/delete_transaction_usecase.dart';
import 'transaction_detail_state.dart';

class TransactionDetailCubit extends Cubit<TransactionDetailState> {
  final DeleteTransactionUseCase deleteTransactionUseCase;

  TransactionDetailCubit({required this.deleteTransactionUseCase})
    : super(const TransactionDetailState());

  Future<void> deleteTransaction(String id, String userId) async {
    emit(state.copyWith(status: TransactionDetailStatus.loading));
    deleteTransactionUseCase.call(userId: userId, transactionId: id);
    emit(state.copyWith(status: TransactionDetailStatus.success));
  }
}
