import 'package:core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<Either<Failure, AuthUser>> call({
    required String name,
    required String email,
    required String password,
  }) async {
    // TODO: Agregar validaciones de dominio o VO'S
    return _repository.registerWithEmail(
      name: name,
      email: email,
      password: password,
    );
  }
}
