import 'package:driver/Custom/button_view.dart';
import 'package:driver/Custom/responsive_text.dart';
import 'package:driver/Helper/navigation_helper.dart';
import 'package:driver/Style/app_theme.dart';
import 'package:driver/Style/fonts.dart';
import 'package:driver/Utils/app_global.dart';
import 'package:driver/Utils/common_widget.dart';
import 'package:flutter/material.dart';

import '../../Helper/AlertHelper.dart';
import '../../Helper/pref_name.dart';
import '../../Helper/preference.dart';
import '../../Model/api_response.dart';
import '../../Model/order_response_model.dart';
import '../../Repository/auth_repository.dart';
import '../../Utils/constants.dart';

class OrderScreenViewModel extends ChangeNotifier{
  late BuildContext context;
  late TabController tabController;

  init(BuildContext context,TickerProvider vsync){
    this.context = context;
    getAllOrder();
    tabController = TabController(length: 4, vsync: vsync);
    notifyListeners();
  }

  goToHomeScreen(){
    AppGlobal.bottomNavigationIndex.value=0;
    notifyListeners();
  }

  ApiResponse<OrderResponseModel?> orderResponse = ApiResponse.initial();
  AuthRepository authenticationRepository = AuthRepository();
  ValueNotifier<bool> loader = ValueNotifier(false);
  List<OrderDataResult> allOrder=[];
  Future<void> getAllOrder() async {
    orderResponse = ApiResponse.loading();
    notifyListeners();
    if (!isInternetAvailable.value) {
      AlertHelper.showAppSnackBar(context,message: "Please check your internet connection");
      orderResponse = ApiResponse.noInternet();
      notifyListeners();
      return;
    }
    Map<String, dynamic> body = {
      "jsonrpc":jsonrpc,
      "params":{
        "driver_id":PreferenceManager.getInt(PrefName.userId),
      }
    };
    loader.value = true;
    notifyListeners();
    try {
      var response = await authenticationRepository.callGetAllOrder(body);
      orderResponse = ApiResponse.completed(response);
      if (orderResponse.data!.result!.status ?? false) {
        allOrder = orderResponse.data?.result?.result??[];
        notifyListeners();
      } else {
        // AlertHelper.showAppSnackBar(context, message: loginResponse.data!.messages ?? "");
      }
      loader.value = false;
      notifyListeners();
    } catch (error) {
      loader.value = false;
      notifyListeners();
      AppGlobal.printLog('OrderListResponse ==> $error');
      orderResponse = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }

  Future<void> showConfirmDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColor.appWhiteColor,
          insetPadding: EdgeInsets.all(padding_20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(padding_06)
          ),
          child: Padding(
            padding: const EdgeInsets.all(padding_10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ResponsiveText(
                  maxLines: 5,
                  text: 'Please process the current order as displayed in the dashboard.',
                  style: Fonts.regularTextStyleMedium.copyWith(
                    fontSize: fontSize_16
                  ),
                ),
                CommonWidget.getFieldSpacer(height: padding_20),
                ButtonView(
                  buttonTextName: 'Ok',
                  onPressed: (){
                    NavigatorHelper.remove();
                  },
                  height: 45,
                )
              ],
            ),
          ),
        );
      },
    );
  }

}