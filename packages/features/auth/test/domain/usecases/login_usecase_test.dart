import 'package:auth/domain/entities/auth_user.dart';
import 'package:auth/domain/repositories/auth_repository.dart';
import 'package:auth/domain/usecases/login_usecase.dart';
import 'package:core/errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = LoginUseCase(mockAuthRepository);
  });

  const tEmail = 'test@test.com';
  const tPassword = 'password123';
  const tAuthUser = AuthUser(id: '1', email: tEmail);

  test(
    'call loginWithEmail from repository and return AuthUser on success',
    () async {
      when(
        () => mockAuthRepository.loginWithEmail(
          email: tEmail,
          password: tPassword,
        ),
      ).thenAnswer((_) async => const Right(tAuthUser));

      final result = await useCase(email: tEmail, password: tPassword);

      expect(result, const Right(tAuthUser));
      verify(
        () => mockAuthRepository.loginWithEmail(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );

  test('return Failure when repository call on unsuccessful', () async {
    const tFailure = ServerFailure('Login failed');
    when(
      () =>
          mockAuthRepository.loginWithEmail(email: tEmail, password: tPassword),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await useCase(email: tEmail, password: tPassword);

    expect(result, const Left(tFailure));
    verify(
      () =>
          mockAuthRepository.loginWithEmail(email: tEmail, password: tPassword),
    ).called(1);
  });
}
