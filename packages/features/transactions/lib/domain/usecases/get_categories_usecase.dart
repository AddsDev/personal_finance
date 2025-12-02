import '../entities/category.dart';
import '../repositories/transactions_repository.dart';

class GetCategoriesUseCase {
  final TransactionsRepository _repository;

  GetCategoriesUseCase(this._repository);

  Future<List<Category>> call() async {
    return _repository.getCategories();
  }
}
