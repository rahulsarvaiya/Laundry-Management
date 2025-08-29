import 'package:flutter/material.dart';

class OrderDetailScreenViewModel extends ChangeNotifier{
  late BuildContext context;

  init(BuildContext context){
    this.context = context;
    notifyListeners();
  }

  // pickUpOrderDialog(){
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return PickUpDialog();
  //     },
  //   );
  // }

}