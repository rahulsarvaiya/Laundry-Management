import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

import '../Utils/constants.dart';

class InternetChecker {
  late StreamSubscription<List<ConnectivityResult>> subscription;

  void startMonitoring() {
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      debugPrint('startMonitoring ==> ${'onConnectivityChanged'}');
      debugPrint('startMonitoring ==> ${result.toString()}');
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

  Future<bool> _checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}

// import 'dart:async';
// import 'dart:developer';
// import 'dart:io';
// import 'package:connectivity/connectivity.dart';
// import 'package:cph4/Utils/Constants.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
//
// class InternetChecker {
//   late StreamSubscription<ConnectivityResult> subscription;
//
//   void startMonitoring(BuildContext context) {
//     _checkInternet().then((isConnected) {
//       isInternetAvailable.value = isConnected;
//     });
//
//     subscription = Connectivity().onConnectivityChanged.listen((result) {
//       if (result == ConnectivityResult.none) {
//         isInternetAvailable.value = false;
//         log('No Internet');
//         // AlertHelper.showAppSnackBar(scaffoldMessengerKey.currentState!.context, message: 'No Internet');
//       } else {
//         _checkInternet().then((isConnected) {
//           isInternetAvailable.value = isConnected;
//         });
//       }
//     });
//   }
//
//   Future<bool> _checkInternet() async {
//     if (kIsWeb) {
//       return true;
//     } else {
//       try {
//         final result = await InternetAddress.lookup('google.com');
//         return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
//       } on SocketException catch (_) {
//         return false;
//       }
//     }
//   }
// }
