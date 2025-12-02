import 'package:auth/auth.dart';
import 'package:auth/domain/repositories/auth_repository.dart';
import 'package:auth/domain/usecases/login_usecase.dart';
import 'package:auth/domain/usecases/logout_usecase.dart';
import 'package:auth/domain/usecases/register_usecase.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockLogoutUseCase extends Mock implements LogoutUseCase {}

void main() {
  late AuthRepository authRepository;
  late LoginUseCase loginUseCase;
  late RegisterUseCase registerUseCase;
  late LogoutUseCase logoutUseCase;
  late AuthBloc authBloc;

  const tUser = AuthUser(id: '1', email: 'test@test.com', name: 'Adrian Test');

  setUp(() {
    authRepository = MockAuthRepository();
    loginUseCase = MockLoginUseCase();
    registerUseCase = MockRegisterUseCase();
    logoutUseCase = MockLogoutUseCase();

    when(() => authRepository.user).thenAnswer((_) => const Stream.empty());

    authBloc = AuthBloc(
      authRepository: authRepository,
      loginUseCase: loginUseCase,
      registerUseCase: registerUseCase,
      logoutUseCase: logoutUseCase,
    );
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    test('initial state is unauthenticated', () {
      expect(authBloc.state, const AuthState.unauthenticated());
    });

    blocTest<AuthBloc, AuthState>(
      'emits [loading, authenticated] when login succeeds',
      setUp: () {
        when(
          () => loginUseCase(email: 'test@test.com', password: 'password'),
        ).thenAnswer((_) async => const Right(tUser));
      },
      build: () => authBloc,
      act:
          (bloc) =>
              bloc.add(const AuthLoginRequested('test@test.com', 'password')),
      expect:
          () => [
            const AuthState(
              isLoading: true,
              status: AuthStatus.unauthenticated,
            ),
            const AuthState.authenticated(tUser),
          ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, unauthenticated] with error when login fails',
      setUp: () {
        when(
          () => loginUseCase(email: 'test@test.com', password: 'password'),
        ).thenAnswer((_) async => const Left(AuthFailure('Login failed')));
      },
      build: () => authBloc,
      act:
          (bloc) =>
              bloc.add(const AuthLoginRequested('test@test.com', 'password')),
      expect:
          () => [
            const AuthState(
              isLoading: true,
              status: AuthStatus.unauthenticated,
            ),
            const AuthState(
              isLoading: false,
              status: AuthStatus.unauthenticated,
              errorMessage: 'Login failed',
            ),
          ],
    );

    blocTest<AuthBloc, AuthState>(
      'calls logout use case when logout requested',
      setUp: () {
        when(() => logoutUseCase()).thenAnswer((_) async => const Right(null));
      },
      build: () => authBloc,
      act: (bloc) => bloc.add(AuthLogoutRequested()),
      verify: (_) {
        verify(() => logoutUseCase()).called(1);
      },
    );
  });
}
