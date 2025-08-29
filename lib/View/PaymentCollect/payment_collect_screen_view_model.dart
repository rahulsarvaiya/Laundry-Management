import 'package:flutter/material.dart';

class PaymentCollectScreenViewModel extends ChangeNotifier{
  late BuildContext context;

  TextEditingController amountController = TextEditingController();
  FocusNode amountFocusNode = FocusNode();

  TextEditingController refNoController = TextEditingController();
  FocusNode refFocusNode = FocusNode();

  init(BuildContext context){
    this.context = context;
    notifyListeners();
  }

  PaymentMethod? selectedPaymentMethod;

  changePaymentMethod(PaymentMethod value){
    selectedPaymentMethod = value;
    notifyListeners();
  }

}
enum PaymentMethod{cash,upi}