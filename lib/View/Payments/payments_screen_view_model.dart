import 'package:flutter/material.dart';

import '../../Utils/app_global.dart';

class PaymentsScreenViewModel extends ChangeNotifier{
  late BuildContext context;

  init(BuildContext context){
    this.context = context;
    notifyListeners();
  }

  goToHomeScreen(){
    AppGlobal.bottomNavigationIndex.value=0;
    notifyListeners();
  }

}