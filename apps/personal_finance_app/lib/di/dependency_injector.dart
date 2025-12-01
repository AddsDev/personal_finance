import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth/di/auth_dependency_injection.dart';
import '../../firebase_options.dart';

final it = GetIt.instance;

Future<void> setupDI() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  it.registerLazySingleton(() => FirebaseAuth.instance);

  AuthDependencyInjection.inject(it);

}