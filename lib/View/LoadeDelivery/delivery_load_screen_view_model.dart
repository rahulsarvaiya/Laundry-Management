import 'package:driver/Model/load_delivery_response.dart';
import 'package:flutter/material.dart';

import '../../Helper/AlertHelper.dart';
import '../../Helper/pref_name.dart';
import '../../Helper/preference.dart';
import '../../Model/api_response.dart';
import '../../Repository/auth_repository.dart';
import '../../Utils/app_global.dart';
import '../../Utils/constants.dart';

class DeliveryLoadScreenViewModel extends ChangeNotifier{
  late BuildContext context;

  init(BuildContext context){
    this.context = context;
    refreshUI();
    // loadDeliveryAPICall();
    notifyListeners();
  }


  changeLoad(int index){
    allDelivery[index].isSelected = !allDelivery[index].isSelected;
    bool isExists = loadList.any((element)=>element.orderId==allDelivery[index].orderId);
    if(isExists){
      int index1 = loadList.indexWhere((element)=>element.orderId==allDelivery[index].orderId);
      loadList.removeAt(index1);
      loadList.insert(index1, LoadModel(orderId:allDelivery[index].orderId??0 , isSelected: allDelivery[index].isSelected));
    }
    else{
      loadList.add(LoadModel(orderId: allDelivery[index].orderId??0, isSelected: allDelivery[index].isSelected));
    }

    notifyListeners();
  }
  List<LoadModel> loadList=[];


  bool isRefreshing = false;
  void refreshUI() async {
    isRefreshing = true;
    notifyListeners();
    await loadDeliveryAPICall();
    // await Future.delayed(Duration(seconds: 3));
    isRefreshing = false;
    notifyListeners();
  }

  ApiResponse<LoadDeliveryResponse?> dashboardResponse = ApiResponse.initial();
  AuthRepository authenticationRepository = AuthRepository();
  ValueNotifier<bool> loader = ValueNotifier(false);
  List<LoadResult> allDelivery=[];
  Future<void> loadDeliveryAPICall() async {
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
        "driver_id":PreferenceManager.getInt(PrefName.userId),
      }
    };
    loader.value = true;
    notifyListeners();
    try {
      var response = await authenticationRepository.callLoadDelivery(body);
      dashboardResponse = ApiResponse.completed(response);
      if (dashboardResponse.data!.result!.status ?? false) {
        allDelivery = dashboardResponse.data?.result?.result??[];
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

class LoadModel{
  int orderId;
  bool isSelected;

  LoadModel({required this.orderId, required this.isSelected});
}