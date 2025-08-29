import 'package:flutter/material.dart';

import '../../Helper/AlertHelper.dart';
import '../../Model/api_response.dart';
import '../../Model/order_details_response_model.dart';
import '../../Repository/auth_repository.dart';
import '../../Utils/app_global.dart';
import '../../Utils/constants.dart';

class OrderDetailScreenViewModel extends ChangeNotifier{
  late BuildContext context;

  init(BuildContext context,String orderId,String orderType,bool isQuickOrder){
    this.context = context;
    getOrderDetails(orderId,orderType,isQuickOrder);
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

  ApiResponse<OrderDetailsResponseModel?> orderDetailsResponse = ApiResponse.initial();
  AuthRepository authenticationRepository = AuthRepository();
  ValueNotifier<bool> loader = ValueNotifier(false);
  OrderDetailResult? orderDetail;
  Future<void> getOrderDetails(String orderId,String orderType,bool isQuickOrder) async {
    orderDetailsResponse = ApiResponse.loading();
    notifyListeners();
    if (!isInternetAvailable.value) {
      AlertHelper.showAppSnackBar(context,message: "Please check your internet connection");
      orderDetailsResponse = ApiResponse.noInternet();
      notifyListeners();
      return;
    }
    Map<String, dynamic> body = {
      "jsonrpc":jsonrpc,
      "params":{
        "order_id":orderId,
        "order_type":orderType,
        "quick_order":isQuickOrder
      }
    };
    loader.value = true;
    notifyListeners();
    try {
      var response = await authenticationRepository.callOrderDetails(body);
      orderDetailsResponse = ApiResponse.completed(response);
      if (orderDetailsResponse.data!.result!=null) {
        orderDetail = orderDetailsResponse.data?.result;
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