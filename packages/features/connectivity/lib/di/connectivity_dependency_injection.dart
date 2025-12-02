import 'package:connectivity/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

import '../data/network_info_impl.dart';

class ConnectivityDependencyInjection {
  static void inject(GetIt it) {
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
