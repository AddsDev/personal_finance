import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

import '../data/datasources/transactions_remote_data_source.dart';
import '../data/repositories/transactions_repository_impl.dart';
import '../domain/repositories/transactions_repository.dart';
import '../domain/usecases/add_transaction_usecase.dart';
import '../domain/usecases/delete_transaction_usecase.dart';
import '../domain/usecases/get_categories_usecase.dart';
import '../domain/usecases/update_transaction_usecase.dart';
import '../presentation/bloc/transaction_bloc.dart';

class TransactionsDependencyInjection {
  static void inject(GetIt it) {
    //External
    if (!it.isRegistered<FirebaseFirestore>()) {
      it.registerLazySingleton(() {
        FirebaseFirestore.instance.settings = const Settings(
          persistenceEnabled: true,
        );
        return FirebaseFirestore.instance;
      });
    }

    // Data Sources
    if (!it.isRegistered<TransactionsRemoteDataSource>()) {
      it.registerLazySingleton<TransactionsRemoteDataSource>(
        () => TransactionsRemoteDataSourceImpl(it<FirebaseFirestore>()),
      );
    }

    // Repositories
    it.registerLazySingleton<TransactionsRepository>(
      () => TransactionsRepositoryImpl(it<TransactionsRemoteDataSource>()),
    );

    // BLoCs
    it.registerFactory<TransactionBloc>(
      () => TransactionBloc(repository: it<TransactionsRepository>()),
    );

    // UseCases
    it.registerLazySingleton<AddTransactionUseCase>(
      () => AddTransactionUseCase(it<TransactionsRepository>()),
    );
    it.registerLazySingleton<UpdateTransactionUseCase>(
      () => UpdateTransactionUseCase(it<TransactionsRepository>()),
    );
    it.registerLazySingleton<GetCategoriesUseCase>(
      () => GetCategoriesUseCase(it<TransactionsRepository>()),
    );
    it.registerLazySingleton<DeleteTransactionUseCase>(
      () => DeleteTransactionUseCase(it<TransactionsRepository>()),
    );
  }
}
