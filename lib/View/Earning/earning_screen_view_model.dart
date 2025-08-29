import 'package:flutter/material.dart';

class EarningScreenViewModel extends ChangeNotifier{
  late BuildContext context;

  init(BuildContext context){
    this.context = context;
    notifyListeners();
  }

}