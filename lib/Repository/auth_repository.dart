import 'dart:convert';

import 'package:driver/Model/dashboard_response.dart';
import 'package:driver/Model/load_delivery_response.dart';
import 'package:driver/Model/login_response.dart';
import 'package:driver/Model/order_done_response.dart';
import 'package:driver/Model/order_response_model.dart';

import '../Model/order_details_response_model.dart';
import '../Network/app_url.dart';
import '../Network/network_api_services.dart';
import '../Utils/app_global.dart';

class AuthRepository{

  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<LoginResponse> callLogin({required Map<String, dynamic> loginBody})async{
    try {
      var response = await _apiServices.getPostApiResponse(AppUrl.login,jsonEncode(loginBody));
      LoginResponse loginResponseModel = LoginResponse.fromJson(response);
      if(loginResponseModel.result!.status!) {
        return loginResponseModel;
      } else {
        return loginResponseModel;
      }
    } catch (e, st) {
      AppGlobal.printLog('loginResponseModel error ==> ${e.toString()} $st');
      rethrow;
    }
  }

  Future<DashboardResponse> callGetDashboardData(Map<String,dynamic> body)async{
    try{
      var response = await _apiServices.getPostApiResponse(AppUrl.dashboard,jsonEncode(body));
      DashboardResponse dashboardResponse = DashboardResponse.fromJson(response);
      if(dashboardResponse.result!.status!) {
        return dashboardResponse;
      } else {
        return dashboardResponse;
      }
    }
    catch(e,st){
      AppGlobal.printLog('dashboardResponse error ==> ${e.toString()} $st');
      rethrow;
    }
  }

  Future<LoadDeliveryResponse> callLoadDelivery(Map<String,dynamic> body)async{
    try{
      var response = await _apiServices.getPostApiResponse(AppUrl.loadDelivery,jsonEncode(body));
      LoadDeliveryResponse loadDeliveryResponse = LoadDeliveryResponse.fromJson(response);
      if(loadDeliveryResponse.result!.status!) {
        return loadDeliveryResponse;
      } else {
        return loadDeliveryResponse;
      }
    }
    catch(e,st){
      AppGlobal.printLog('callLoadDelivery error ==> ${e.toString()} $st');
      rethrow;
    }
  }

  Future<OrderResponseModel> callGetAllOrder(Map<String,dynamic> body)async{
    try{
      var response = await _apiServices.getPostApiResponse(AppUrl.start,jsonEncode(body));
      OrderResponseModel orderListResponse = OrderResponseModel.fromJson(response);
      if(orderListResponse.result!.status!) {
        return orderListResponse;
      } else {
        return orderListResponse;
      }
    }
    catch(e,st){
      AppGlobal.printLog('callGetAllOrder error ==> ${e.toString()} $st');
      rethrow;
    }
  }

  Future<OrderDetailsResponseModel> callOrderDetails(Map<String,dynamic> body)async{
    try{
      var response = await _apiServices.getPostApiResponse(AppUrl.orderId,jsonEncode(body));
      OrderDetailsResponseModel orderListResponse = OrderDetailsResponseModel.fromJson(response);
      if(orderListResponse.result!=null) {
        return orderListResponse;
      } else {
        return orderListResponse;
      }
    }
    catch(e,st){
      AppGlobal.printLog('callOrderDetails error ==> ${e.toString()} $st');
      rethrow;
    }
  }

  Future<OrderDoneDoneResponse> callOrderDelivery(Map<String,dynamic> body)async{
    try{
      var response = await _apiServices.getPostApiResponse(AppUrl.deliveryDone,jsonEncode(body));
      OrderDoneDoneResponse orderListResponse = OrderDoneDoneResponse.fromJson(response);
      if(orderListResponse.result!=null) {
        return orderListResponse;
      } else {
        return orderListResponse;
      }
    }
    catch(e,st){
      AppGlobal.printLog('callOrderDelivery error ==> ${e.toString()} $st');
      rethrow;
    }
  }
  Future<OrderDoneDoneResponse> callPickDelivery(Map<String,dynamic> body)async{
    try{
      var response = await _apiServices.getPostApiResponse(AppUrl.pickupDone,jsonEncode(body));
      OrderDoneDoneResponse orderListResponse = OrderDoneDoneResponse.fromJson(response);
      if(orderListResponse.result!=null) {
        return orderListResponse;
      } else {
        return orderListResponse;
      }
    }
    catch(e,st){
      AppGlobal.printLog('callPickupDelivery error ==> ${e.toString()} $st');
      rethrow;
    }
  }
}