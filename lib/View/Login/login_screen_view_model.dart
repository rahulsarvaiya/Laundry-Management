import 'package:driver/Helper/AlertHelper.dart';
import 'package:driver/Helper/navigation_helper.dart';
import 'package:driver/Model/login_response.dart';
import 'package:flutter/material.dart';
import '../../Helper/pref_name.dart';
import '../../Helper/preference.dart';
import '../../Model/api_response.dart';
import '../../Repository/auth_repository.dart';
import '../../Utils/app_global.dart';
import '../../Utils/constants.dart';
import '../BottomNavigationBar/bottom_navigation_bar_screen.dart';

class LoginScreenViewModel extends ChangeNotifier{
  late BuildContext context;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  ValueNotifier<bool> loginLoader = ValueNotifier(false);
  init(BuildContext context){
    this.context = context;
    notifyListeners();
  }

  onLogin(){
    if (formKey.currentState!.validate()){
      userLoginApi();
    }
  }
  ApiResponse<LoginResponse?> loginResponse = ApiResponse.initial();
  AuthRepository authenticationRepository = AuthRepository();
  Future<void> userLoginApi() async {
    loginResponse = ApiResponse.loading();
    notifyListeners();
    if (!isInternetAvailable.value) {
      AlertHelper.showAppSnackBar(context,message: "Please check your internet connection");
      loginResponse = ApiResponse.noInternet();
      notifyListeners();
      return;
    }
    Map<String, dynamic> body = {
     "jsonrpc":jsonrpc,
      "params":{
       "username":emailController.text.trim(),
        "password":passwordController.text.trim(),
        "db":db,
      }
    };
    loginLoader.value = true;
    notifyListeners();
    try {
      var response = await authenticationRepository.callLogin(loginBody: body);
      loginResponse = ApiResponse.completed(response);
      if (loginResponse.data!.result!.status ?? false) {
        AlertHelper.showAppSnackBar(context,message: loginResponse.data?.result?.message??"");
        PreferenceManager.setBoolean(PrefName.isLogin, true);
        PreferenceManager.setInt(PrefName.userId, loginResponse.data?.result?.result?.userData?.userId??0);
        PreferenceManager.setInt(PrefName.partnerId, loginResponse.data?.result?.result?.userData?.partnerId??0);
        PreferenceManager.setString(PrefName.name, loginResponse.data?.result?.result?.userData?.name??"");
        PreferenceManager.setString(PrefName.userName, loginResponse.data?.result?.result?.userData?.username??"");
        PreferenceManager.setString(PrefName.partnerName, loginResponse.data?.result?.result?.userData?.partnerDisplayName??"");
        NavigatorHelper.removeAllAndOpen(BottomNavigationBarScreen());
        notifyListeners();
      } else {
        // AlertHelper.showAppSnackBar(context, message: loginResponse.data!.messages ?? "");
      }
      loginLoader.value = false;
      notifyListeners();
    } catch (error) {
      loginLoader.value = false;
      notifyListeners();
      AppGlobal.printLog('loginResponse ==> $error');
      loginResponse = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }

}