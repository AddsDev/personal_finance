import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/datasources/auth_remote_data_source.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/logout_usecase.dart';
import '../domain/usecases/register_usecase.dart';
import '../presentation/bloc/auth_bloc.dart';

class AuthDependencyInjection {
  static void inject(GetIt it) {
    // Data Sources
    it.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(firebaseAuth: it<FirebaseAuth>()),
    );

    // Repositories
    it.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(it<AuthRemoteDataSource>()),
    );

    // Use Cases
    it.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(it<AuthRepository>()),
    );

    it.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(it<AuthRepository>()),
    );

    it.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(it<AuthRepository>()),
    );


    // BLoCs
    it.registerFactory<AuthBloc>(
      () => AuthBloc(
        authRepository: it<AuthRepository>(),
        loginUseCase: it<LoginUseCase>(),
        registerUseCase: it<RegisterUseCase>(),
        logoutUseCase: it<LogoutUseCase>(),
      ),
    );
  }
}
