import 'package:core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';
import '../entities/auth_user.dart';

abstract class AuthRepository {
  Stream<AuthUser> get user;

  Future<Either<Failure, AuthUser>> loginWithEmail({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthUser>> registerWithEmail({
    required String name,
    required String email,
    required String password,
  });

  Future<void> logout();
}