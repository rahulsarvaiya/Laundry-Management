import 'package:driver/Custom/button_view.dart';
import 'package:driver/Custom/custom_text_field.dart';
import 'package:driver/Helper/assets_helper.dart';
import 'package:driver/Style/app_theme.dart';
import 'package:driver/Style/fonts.dart';
import 'package:driver/Utils/common_widget.dart';
import 'package:driver/Utils/constants.dart';
import 'package:driver/View/Login/login_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  LoginScreenViewModel loginScreenViewModel = LoginScreenViewModel();

  @override
  void initState() {
    super.initState();
    loginScreenViewModel.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => loginScreenViewModel,
      child: Consumer<LoginScreenViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: AppColor.appWhiteColor,
            body: SingleChildScrollView(
              padding: EdgeInsets.all(padding_20),
              child: Form(
                key: viewModel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget.getFieldSpacer(height: padding_20),
                    AssetsHelper.getAssetImage(name: 'app_logo_light.jpeg'),
                    Text("Welcome back",style: Fonts.regularTextStyleBold.copyWith(
                      fontSize: fontSize_22
                    ),),
                    Text("Login to continue",style: Fonts.regularTextStyle.copyWith(
                        fontSize: fontSize_14
                    ),),
                    CommonWidget.getFieldSpacer(height: padding_60),
                    CustomTextField(
                        tecController: viewModel.emailController,
                        focusNode: viewModel.emailFocusNode,
                        hintText: "Email / User Name",
                        prefixIcon: 'ic_mail.svg',
                        isShowPrefixIcon: true,
                        prefixIconHeight: 20,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email or User Name';
                        }
                        return null;
                      },
                    ),
                    CommonWidget.getFieldSpacer(height: padding_20),
                    CustomTextField(
                        tecController: viewModel.passwordController,
                        focusNode: viewModel.passwordFocusNode,
                        hintText: "Password",
                      prefixIcon: 'ic_lock.svg',
                      isShowPrefixIcon: true,
                      prefixIconHeight: 20,
                      isShowSuffixIcon: true,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),

                    CommonWidget.getFieldSpacer(height: padding_60),
                    ButtonView(
                      buttonTextName: 'Login',
                      onPressed: (){
                        viewModel.onLogin();
                      },
                      vnIsShowLoader: viewModel.loginLoader,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
