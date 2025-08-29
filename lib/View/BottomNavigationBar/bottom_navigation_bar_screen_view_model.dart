import 'package:driver/View/Order/order_screen.dart';
import 'package:driver/View/Payments/payments_screen.dart';
import 'package:flutter/material.dart';

import '../../Utils/app_global.dart';
import '../Dashboard/dashboard_screen.dart';

class BottomNavigationBarScreenViewModel extends ChangeNotifier{
  late BuildContext context;

  late PageController pageController;

  List<Widget> bottomNavScreenList = [
    const DashboardScreen(),
    const OrderScreen(),
    const PaymentsScreen(),
  ];

  init(BuildContext context){
    this.context = context;
    pageController = PageController();
    AppGlobal.bottomNavigationIndexVal.addListener(() {
      changeIndex(AppGlobal.bottomNavigationIndex.value, true);
    });
    notifyListeners();
  }

  changeIndex(value, bool ignore) {
    if (!ignore) {
      if (AppGlobal.bottomNavigationIndex.value == value) return;
    }
    pageController.animateToPage(value, duration: const Duration(milliseconds: 600), curve: Curves.ease);
    AppGlobal.bottomNavigationIndex.value = value;
    notifyListeners();
  }

}