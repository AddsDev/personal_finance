import 'package:connectivity/connectivity.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth/di/auth_dependency_injection.dart';
import 'package:transactions/di/transactions_dependency_injection.dart';
import '../../firebase_options.dart';

final it = GetIt.instance;

Future<void> setupDI() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseAppCheck.instance.activate(
    providerAndroid: AndroidDebugProvider(),
    providerApple: AppleDebugProvider(),
    providerWeb: ReCaptchaV3Provider('6LehZx0sAAAAALrk1LdvlzvlZB62bAygGUInUuYK'),
  );

  it.registerLazySingleton(() => FirebaseAuth.instance);

  ConnectivityDependencyInjection.inject(it);
  AuthDependencyInjection.inject(it);
  TransactionsDependencyInjection.inject(it);
}