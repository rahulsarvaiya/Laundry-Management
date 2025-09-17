import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Utils/app_global.dart';
import 'Utils/constants.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();

  final Widget? child;

  BaseScreen({Key? key, this.child}) : super(key: key);
}

class _BaseScreenState extends State<BaseScreen> with WidgetsBindingObserver {
  // final LocalAuthentication _localAuth = LocalAuthentication();
  List availableBioMetrics = [];
  bool isAuthenticated = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    _checkInternet();

    Connectivity().onConnectivityChanged.listen((result) {
      if (result.contains(ConnectivityResult.mobile) ) {
        isInternetAvailable.value = true;
      }
      else if (result.contains(ConnectivityResult.wifi)) {
        isInternetAvailable.value = true;
      }
      else if(result.contains(ConnectivityResult.ethernet)){
        isInternetAvailable.value = true;
      }
      else {
        isInternetAvailable.value = false;
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      AppGlobal.printLog("LifeCycle ==> Screen Resumed $isAuthenticated");
    } else if (state == AppLifecycleState.paused) {
      AppGlobal.printLog("LifeCycle ==> Screen Paused");
      isAuthenticated = false;
    } else if (state == AppLifecycleState.detached) {
      AppGlobal.printLog("LifeCycle ==> Screen Detached");
    } else if (state == AppLifecycleState.inactive) {
      AppGlobal.printLog("LifeCycle ==> Screen Inactive");
    }
  }

  _checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    AppGlobal.printLog("===================pre check global internet status is ${isInternetAvailable.value}=========================");

    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      isInternetAvailable.value = true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      isInternetAvailable.value = true;
    }
    else if(connectivityResult.contains(ConnectivityResult.ethernet)){
      isInternetAvailable.value = true;
    }
    else {
      isInternetAvailable.value = false;
    }

    AppGlobal.printLog("===================global internet status is ${isInternetAvailable.value}=========================");
  }

}
