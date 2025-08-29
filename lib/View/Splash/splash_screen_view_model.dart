import 'dart:async';
import 'package:driver/Helper/pref_name.dart';
import 'package:driver/Helper/preference.dart';
import 'package:driver/View/Login/login_screen.dart';
import 'package:flutter/material.dart';

import '../../Helper/navigation_helper.dart';
import '../BottomNavigationBar/bottom_navigation_bar_screen.dart';

class SplashScreenViewModel extends ChangeNotifier{

  late BuildContext context;

  init(BuildContext context){
    this.context = context;
    startTime();
    notifyListeners();
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, navigationPage);
  }

  void navigationPage()async{
    bool isLogin = PreferenceManager.getBoolean(PrefName.isLogin);
    if(isLogin){
      NavigatorHelper.removeAllAndOpen(BottomNavigationBarScreen());
    }
    else{
      NavigatorHelper.removeAllAndOpen(LoginScreen());
    }
    // bool isIntroDone = PreferenceManager.getBoolean(PrefName.intro);
    // if(!isIntroDone){
    //   NavigatorHelper.removeAllAndOpen(IntroScreen());
    // }
    // else{

    // }
  }
}