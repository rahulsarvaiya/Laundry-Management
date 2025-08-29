import 'dart:io';

import 'package:driver/Custom/button_view.dart';
import 'package:driver/Custom/custom_text_field.dart';
import 'package:driver/Utils/app_global.dart';
import 'package:driver/Utils/common_widget.dart';
import 'package:driver/View/BottomNavigationBar/bottom_navigation_bar_screen.dart';
import 'package:driver/View/PaymentCollect/payment_collect_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../Custom/custom_text_button.dart';
import '../../Custom/responsive_text.dart';
import '../../Helper/navigation_helper.dart';
import '../../Style/Fonts.dart';
import '../../Style/app_theme.dart';
import '../../Utils/Constants.dart';
class PaymentCollectScreen extends StatefulWidget {
  const PaymentCollectScreen({super.key});

  @override
  State<PaymentCollectScreen> createState() => _PaymentCollectScreenState();
}

class _PaymentCollectScreenState extends State<PaymentCollectScreen> {

  PaymentCollectScreenViewModel paymentCollectScreenViewModel = PaymentCollectScreenViewModel();

  @override
  void initState() {
    super.initState();
    paymentCollectScreenViewModel.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => paymentCollectScreenViewModel,
      child: Consumer<PaymentCollectScreenViewModel>(
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
                text: "Payment Collect",
                style: Fonts.regularTextStyleBold.copyWith(
                  fontSize: fontSize_16,
                  color: AppColor.appWhiteColor,
                ),
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(padding_20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        text: "Order ID : ",
                        style: Fonts.regularTextStyle.copyWith(
                            color: Colors.grey
                        ),
                        children: [
                          TextSpan(
                              text: "#48523618",
                              style: Fonts.regularTextStyleMedium
                          )
                        ]
                    ),
                  ),
                  CommonWidget.getFieldSpacer(height: padding_04),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        text: "Customer: ",
                        style: Fonts.regularTextStyle.copyWith(
                            color: Colors.grey
                        ),
                        children: [
                          TextSpan(
                              text: "John Doe",
                              style: Fonts.regularTextStyleMedium
                          )
                        ]
                    ),
                  ),
                  CommonWidget.getFieldSpacer(height: padding_04),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        text: "Delivery Address: ",
                        style: Fonts.regularTextStyle.copyWith(
                            color: Colors.grey
                        ),
                        children: [
                          TextSpan(
                              text: "123 Main Street, New York, NY",
                              style: Fonts.regularTextStyleMedium
                          )
                        ]
                    ),
                  ),
                  CommonWidget.getFieldSpacer(height: padding_04),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        text: "Payment: ",
                        style: Fonts.regularTextStyle.copyWith(
                            color: Colors.grey
                        ),
                        children: [
                          TextSpan(
                              text: "AED 500 (Paid Online)",
                              style: Fonts.regularTextStyleMedium
                          )
                        ]
                    ),
                  ),
                  CommonWidget.getFieldSpacer(height: padding_20),
                  ResponsiveText(
                    text: "Payment method",
                    style: Fonts.regularTextStyleBold.copyWith(
                      fontSize: fontSize_20
                    ),
                  ),
                  RadioListTile(
                    value: PaymentMethod.upi,
                    groupValue: viewModel.selectedPaymentMethod,
                    hoverColor: Colors.transparent,
                    onChanged: (value) {
                      viewModel.changePaymentMethod(value!);
                    },
                    title: Text("Online",style: Fonts.regularTextStyleMedium,),
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                  ),
                  RadioListTile(
                    value: PaymentMethod.cash,
                    groupValue: viewModel.selectedPaymentMethod,
                    hoverColor: Colors.transparent,
                    onChanged: (value) {
                      viewModel.changePaymentMethod(value!);
                    },
                    title: Text("Cash",style: Fonts.regularTextStyleMedium,),
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                  ),
                  Visibility(
                    visible: viewModel.selectedPaymentMethod == PaymentMethod.cash,
                    replacement: Visibility(
                      visible: viewModel.selectedPaymentMethod == PaymentMethod.upi,
                      child: Padding(
                        padding: const EdgeInsets.only(top: padding_20),
                        child: Column(
                          children: [
                            CustomTextField(
                              tecController: viewModel.refNoController,
                              focusNode: viewModel.refFocusNode,
                              hintText: "Reference number",
                              textInputType: TextInputType.text,
                            ),
                            CommonWidget.getFieldSpacer(height: padding_16),
                            CustomTextField(
                              tecController: viewModel.amountController,
                              focusNode: viewModel.amountFocusNode,
                              hintText: "Enter amount",
                              textInputType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly, // ✅ Only allows 0–9
                              ],
                              prefixIconWidget: Text("AED",style: Fonts.regularTextStyleMedium,),
                              isShowPrefixIcon: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: padding_20),
                      child: CustomTextField(
                        tecController: viewModel.amountController,
                        focusNode: viewModel.amountFocusNode,
                        hintText: "Enter amount",
                        textInputType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly, // ✅ Only allows 0–9
                        ],
                        prefixIconWidget: Text("AED",style: Fonts.regularTextStyleMedium,),
                        isShowPrefixIcon: true,
                      ),
                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.all(padding_20),
              child: Row(
                children: [
                  Expanded(
                    child: ButtonView(
                      buttonTextName: "Pending",
                      onPressed: (){
                        AppGlobal.bottomNavigationIndex.value = 0 ;
                        NavigatorHelper.removeAllAndOpen(BottomNavigationBarScreen());
                      },
                    ),
                  ),
                  CommonWidget.getFieldSpacer(width: padding_20),
                  Expanded(
                    child: ButtonView(
                      onPressed: (){
                        AppGlobal.bottomNavigationIndex.value = 0 ;
                        NavigatorHelper.removeAllAndOpen(BottomNavigationBarScreen());
                      },
                      buttonTextName: "Confirm",
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
