import 'package:flutter/material.dart';

class FeedbackScreenViewModel extends ChangeNotifier{
  late BuildContext context;

  init(BuildContext context){
    this.context = context;
    notifyListeners();
  }
}