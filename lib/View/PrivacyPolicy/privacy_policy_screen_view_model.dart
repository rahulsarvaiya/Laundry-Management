import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrivacyPolicyScreenViewModel extends ChangeNotifier{

  late BuildContext context;

  String htmlContent = '';

  init(BuildContext context){
    this.context = context;
    loadHtml();
    notifyListeners();
  }

  Future<void> loadHtml() async {
    final content = await rootBundle.loadString('assets/images/driver_policy.html');
    htmlContent = content;
    notifyListeners();
  }
}