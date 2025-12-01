import 'package:core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';
import '../repositories/auth_repository.dart';
import '../entities/auth_user.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, AuthUser>> call({
    required String email,
    required String password,
  }) async {
    // TODO: Agregar validaciones de dominio o VO'S
    return _repository.loginWithEmail(email: email, password: password);
  }
}