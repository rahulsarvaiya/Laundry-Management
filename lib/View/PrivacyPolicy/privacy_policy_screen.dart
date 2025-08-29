import 'dart:io';

import 'package:driver/View/PrivacyPolicy/privacy_policy_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../../Custom/custom_text_button.dart';
import '../../Custom/responsive_text.dart';
import '../../Helper/navigation_helper.dart';
import '../../Style/Fonts.dart';
import '../../Style/app_theme.dart';
import '../../Utils/Constants.dart';
class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {

  PrivacyPolicyScreenViewModel privacyPolicyScreenViewModel = PrivacyPolicyScreenViewModel();

  @override
  void initState() {
    super.initState();
    privacyPolicyScreenViewModel.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => privacyPolicyScreenViewModel,
      child: Consumer<PrivacyPolicyScreenViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.appPrimaryColor,
              leading: CustomTextButton(
                onPressed: () {
                  NavigatorHelper.remove();
                },
                child: Icon(
                  Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              title: ResponsiveText(
                text: "Privacy Policy",
                style: Fonts.regularTextStyleBold.copyWith(
                  fontSize: fontSize_16,
                  color: AppColor.appWhiteColor,
                ),
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
            ),
            body: viewModel.htmlContent.isNotEmpty
                ? SingleChildScrollView(child: Html(data: viewModel.htmlContent))
                : Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
