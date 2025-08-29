import 'dart:io';

import 'package:driver/View/TermsAndCondition/terms_and_condition_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../../Custom/custom_text_button.dart';
import '../../Custom/responsive_text.dart';
import '../../Helper/navigation_helper.dart';
import '../../Style/Fonts.dart';
import '../../Style/app_theme.dart';
import '../../Utils/Constants.dart';
class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  State<TermsAndConditionScreen> createState() => _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {

  TermsAndConditionScreenViewModel termsAndConditionScreenViewModel = TermsAndConditionScreenViewModel();

  @override
  void initState() {
    super.initState();
    termsAndConditionScreenViewModel.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => termsAndConditionScreenViewModel,
      child: Consumer<TermsAndConditionScreenViewModel>(
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
                text: "Terms & Condition",
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
