import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import '../../Helper/AlertHelper.dart';
import '../../Helper/navigation_helper.dart';
import '../../Model/api_response.dart';
import '../../Model/order_done_response.dart';
import '../../Repository/auth_repository.dart';
import '../../Utils/app_global.dart';
import '../../Utils/constants.dart';
import '../BottomNavigationBar/bottom_navigation_bar_screen.dart';
import '../PaymentCollect/payment_collect_screen.dart';
class PickUpDialogViewModel extends ChangeNotifier{

  late BuildContext context;

  init(BuildContext context){
    this.context = context;
    notifyListeners();
  }

  String getMimeTypeFromExtension(String path) {
    final ext = p.extension(path).toLowerCase();
    switch (ext) {
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.png':
        return 'image/png';
      case '.gif':
        return 'image/gif';
      case '.webp':
        return 'image/webp';
      default:
        return 'application/octet-stream'; // fallback
    }
  }

  ApiResponse<OrderDoneDoneResponse?> orderDetailsResponse = ApiResponse.initial();
  ValueNotifier<bool> loader = ValueNotifier(false);
  AuthRepository authenticationRepository = AuthRepository();
  Future<void> callOrderDelivery(Map<String,dynamic> body) async {
    orderDetailsResponse = ApiResponse.loading();
    notifyListeners();
    if (!isInternetAvailable.value) {
      AlertHelper.showAppSnackBar(context,message: "Please check your internet connection");
      orderDetailsResponse = ApiResponse.noInternet();
      notifyListeners();
      return;
    }
    loader.value = true;
    notifyListeners();
    try {
      var response = await authenticationRepository.callOrderDelivery(body);
      orderDetailsResponse = ApiResponse.completed(response);
      if (orderDetailsResponse.data!.result!=null) {
          AlertHelper.showAppSnackBar(context,message: orderDetailsResponse.data?.result?.message??"");
          NavigatorHelper.remove();
          NavigatorHelper().add(PaymentCollectScreen());
        notifyListeners();
      }
      loader.value = false;
      notifyListeners();
    } catch (error) {
      loader.value = false;
      notifyListeners();
      AppGlobal.printLog('OrderDetailResponse ==> $error');
      orderDetailsResponse = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }
  Future<void> callPickUpOrder(Map<String,dynamic> body) async {
    orderDetailsResponse = ApiResponse.loading();
    notifyListeners();
    if (!isInternetAvailable.value) {
      AlertHelper.showAppSnackBar(context,message: "Please check your internet connection");
      orderDetailsResponse = ApiResponse.noInternet();
      notifyListeners();
      return;
    }
    loader.value = true;
    notifyListeners();
    try {
      var response = await authenticationRepository.callPickDelivery(body);
      orderDetailsResponse = ApiResponse.completed(response);
      if (orderDetailsResponse.data!.result!=null) {
          AlertHelper.showAppSnackBar(context,message: orderDetailsResponse.data?.result?.message??"");
            AppGlobal.bottomNavigationIndex.value =0;
            NavigatorHelper.replace(BottomNavigationBarScreen());
        notifyListeners();
      }
      loader.value = false;
      notifyListeners();
    } catch (error) {
      loader.value = false;
      notifyListeners();
      AppGlobal.printLog('OrderDetailResponse ==> $error');
      orderDetailsResponse = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }
}