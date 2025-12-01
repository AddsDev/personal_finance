import 'package:core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Stream<AuthUser> get user => _remoteDataSource.user;

  @override
  Future<Either<Failure, AuthUser>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _remoteDataSource.loginWithEmail(email, password);
      return Right(userModel);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ServerFailure('Error inesperado'));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> registerWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _remoteDataSource.registerWithEmail(
        name,
        email,
        password,
      );
      return Right(userModel);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ServerFailure('Error inesperado'));
    }
  }

  @override
  Future<void> logout() async {
    await _remoteDataSource.logout();
  }
}
