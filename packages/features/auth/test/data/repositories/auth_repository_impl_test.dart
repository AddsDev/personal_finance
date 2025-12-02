import 'package:auth/data/datasources/auth_remote_data_source.dart';
import 'package:auth/data/models/auth_user_model.dart';
import 'package:auth/data/repositories/auth_repository_impl.dart';
import 'package:core/errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockDataSource);
  });

  const testEmail = 'test@test.com';
  const testPassword = 'password';
  const testUserModel = AuthUserModel(id: '1', email: testEmail);

  group('loginWithEmail', () {
    test('return AuthUser when call to data source is successful', () async {
      when(
        () => mockDataSource.loginWithEmail(testEmail, testPassword),
      ).thenAnswer((_) async => testUserModel);

      final result = await repository.loginWithEmail(
        email: testEmail,
        password: testPassword,
      );

      expect(result, const Right(testUserModel));
    });

    test('should return ServerFailure when call to '
        'data source throws ServerFailure', () async {
      const tFailure = ServerFailure('Server Error');
      when(
        () => mockDataSource.loginWithEmail(testEmail, testPassword),
      ).thenThrow(tFailure);

      final result = await repository.loginWithEmail(
        email: testEmail,
        password: testPassword,
      );

      expect(result, const Left(tFailure));
    });

    test('return ServerFailure when call to data source'
        ' throws unknown Exception', () async {
      when(
        () => mockDataSource.loginWithEmail(testEmail, testPassword),
      ).thenThrow(Exception());

      final result = await repository.loginWithEmail(
        email: testEmail,
        password: testPassword,
      );

      expect(result, const Left(ServerFailure('Error inesperado')));
    });
  });

  // TODO: Add more tests for registerWithEmail, logout, and user methods
}
