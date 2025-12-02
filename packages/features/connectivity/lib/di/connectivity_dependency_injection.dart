import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

import '../data/network_info_impl.dart';

class ConnectivityDependencyInjection {
  static void inject(GetIt it) {
    //External
    if (!it.isRegistered<FirebaseFirestore>()) {
      it.registerLazySingleton(() {
        FirebaseFirestore.instance.settings = const Settings(
          persistenceEnabled: true,
        );
        return FirebaseFirestore.instance;
      });
    }

    if (!it.isRegistered<Connectivity>()) {
      it.registerLazySingleton(() => Connectivity());
    }

    // Data and domain
    it.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectivity: it()),
    );

    // BLoc
    it.registerLazySingleton<ConnectivityBloc>(
      () => ConnectivityBloc(networkInfo: it()),
    );
  }
}
