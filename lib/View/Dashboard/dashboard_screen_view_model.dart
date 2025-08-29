import 'dart:developer';

import 'package:driver/Custom/button_view.dart';
import 'package:driver/Helper/navigation_helper.dart';
import 'package:driver/Helper/pref_name.dart';
import 'package:driver/Helper/preference.dart';
import 'package:driver/Model/dashboard_response.dart';
import 'package:driver/Style/fonts.dart';
import 'package:driver/Utils/app_global.dart';
import 'package:driver/Utils/common_widget.dart';
import 'package:driver/View/Login/login_screen.dart';
import 'package:flutter/material.dart';

import '../../Helper/AlertHelper.dart';
import '../../Model/api_response.dart';
import '../../Repository/auth_repository.dart';
import '../../Utils/constants.dart';

class DashboardScreenViewModel extends ChangeNotifier{

  late BuildContext context;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  init(BuildContext context){
    this.context = context;
    dashboardApiCall();
    notifyListeners();
  }

  changeOnlineStatus(){
    log("Online value : ${AppGlobal.isOnline.value}");
    AppGlobal.isOnline.value = !AppGlobal.isOnline.value;
    log("Online value : ${AppGlobal.isOnline.value}");
    notifyListeners();
  }
  List<Route> allRoutes=[
    Route(name: "Route 1",
        value: 1,
        routes: [
      Routes(address: "Mumbai", value: 1),
      Routes(address: "Pune", value: 2),
      Routes(address: "Nagpur", value: 3),
    ]),
    // Route(name: "Route 2",
    //     value: 2,
    //     routes: [
    //   Routes(address: "Jaipur", value: 4),
    //   Routes(address: "Jodhpur", value: 5),
    //   Routes(address: "Udaipur", value: 6),
    // ]),
    // Route(name: "Route 3",
    //     value: 3,
    //     routes: [
    //   Routes(address: "Bhopal", value: 7),
    //   Routes(address: "Indore", value: 8),
    //   Routes(address: "Jabalpur", value: 9),
    // ]),
    // Route(name: "Route 4",
    //     value: 4,
    //     routes: [
    //   Routes(address: "New Delhi ", value: 10),
    //   Routes(address: "Rohini", value: 11),
    //   Routes(address: "South West Delhi", value: 12),
    // ]),
  ];

  int? selectedRoutes;

  changeRoute(int value){
    selectedRoutes = value;
    notifyListeners();
  }

  showLogout(){
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.all(padding_20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(padding_04)
          ),
          child: Padding(
            padding: const EdgeInsets.all(padding_16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(child: Text("Logout Confirmation",style: Fonts.regularTextStyleBold.copyWith(
                  fontSize: fontSize_22
                ),)),
                CommonWidget.getFieldSpacer(height: padding_10),
                Text("Are you sure you want to logout?",style: Fonts.regularTextStyle,),
                CommonWidget.getFieldSpacer(height: padding_20),
                Row(
                  children: [
                    Expanded(
                      child: ButtonView(
                        onPressed: (){
                          NavigatorHelper.remove();
                        },
                        buttonTextName: "Cancel",
                        color: Colors.grey,
                        borderColor: Colors.grey,
                        height: 35,
                      ),
                    ),
                    CommonWidget.getFieldSpacer(width: padding_20),
                    Expanded(
                      child: ButtonView(
                        onPressed: (){
                          PreferenceManager.remove(PrefName.isLogin);
                          PreferenceManager.remove(PrefName.partnerId);
                          PreferenceManager.remove(PrefName.partnerName);
                          PreferenceManager.remove(PrefName.userName);
                          PreferenceManager.remove(PrefName.name);
                          PreferenceManager.remove(PrefName.userId);
                          NavigatorHelper.removeAllAndOpen(LoginScreen());
                        },
                        buttonTextName: "Logout",
                        borderColor: Colors.red,
                        color: Colors.red,
                        height: 35,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  bool deliveryLoaded=false;
  changeDeliveryLoad(bool value){
    deliveryLoaded = value;
    notifyListeners();
  }

  ApiResponse<DashboardResponse?> dashboardResponse = ApiResponse.initial();
  AuthRepository authenticationRepository = AuthRepository();
  ValueNotifier<bool> loader = ValueNotifier(false);
  DashboardResult? dashboardResult;
  Future<void> dashboardApiCall() async {
    dashboardResponse = ApiResponse.loading();
    notifyListeners();
    if (!isInternetAvailable.value) {
      AlertHelper.showAppSnackBar(context,message: "Please check your internet connection");
      dashboardResponse = ApiResponse.noInternet();
      notifyListeners();
      return;
    }
    Map<String, dynamic> body = {
      "jsonrpc":jsonrpc,
      "params":{
        "user_id":PreferenceManager.getInt(PrefName.userId),
      }
    };
    loader.value = true;
    notifyListeners();
    try {
      var response = await authenticationRepository.callGetDashboardData(body);
      dashboardResponse = ApiResponse.completed(response);
      if (dashboardResponse.data!.result!.status ?? false) {
        dashboardResult=dashboardResponse.data?.result?.result??DashboardResult();
        notifyListeners();
      } else {
        // AlertHelper.showAppSnackBar(context, message: loginResponse.data!.messages ?? "");
      }
      loader.value = false;
      notifyListeners();
    } catch (error) {
      loader.value = false;
      notifyListeners();
      AppGlobal.printLog('dashboardResponse ==> $error');
      dashboardResponse = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }

}
class Route{
  String name;
  int value;
  List<Routes> routes;

  Route({required this.name, required this.routes,required this.value});


}

class Routes{
  String address;
  int value;

  Routes({required this.address, required this.value,});
}