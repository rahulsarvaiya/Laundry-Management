import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../Utils/constants.dart';

class InternetChecker {
  late StreamSubscription<List<ConnectivityResult>> subscription;

  void startMonitoring() {
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result.contains(ConnectivityResult.mobile)) {
        isInternetAvailable.value = true;
      } else if (result.contains(ConnectivityResult.wifi)) {
        isInternetAvailable.value = true;
      } else if (result.contains(ConnectivityResult.ethernet)) {
        isInternetAvailable.value = true;
      } else if (result.contains(ConnectivityResult.other)) {
        isInternetAvailable.value = false;
      } else if (result.contains(ConnectivityResult.none)) {
        isInternetAvailable.value = false;
      }
    });

  }
}
