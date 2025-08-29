import 'dart:developer';

import 'package:flutter/material.dart';

class AppGlobal{
  static ValueNotifier<int> bottomNavigationIndex = ValueNotifier(0);
  static ValueNotifier<bool> isShowBottomNav = ValueNotifier(true);
  static ValueNotifier<int> get bottomNavigationIndexVal => bottomNavigationIndex;
  static ValueNotifier<bool> isOnline = ValueNotifier(false);

  static printLog(dynamic val) {
    log(val.toString());
  }

  static bool hasBottomNotch(BuildContext context) {
    final padding = MediaQuery.of(context).viewPadding;
    return padding.bottom > 0;
  }
  static bool hasNotch(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    return topPadding > 24.0;
  }
}