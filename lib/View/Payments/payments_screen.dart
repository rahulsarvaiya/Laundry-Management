import 'dart:io';

import 'package:driver/View/Payments/payments_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Custom/custom_text_button.dart';
import '../../Custom/responsive_text.dart';
import '../../Helper/navigation_helper.dart';
import '../../Style/Fonts.dart';
import '../../Style/app_theme.dart';
import '../../Utils/Constants.dart';
import '../../Utils/common_widget.dart';
import '../OrderDetail/order_detail_screen.dart';
class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {

  PaymentsScreenViewModel paymentsScreenViewModel = PaymentsScreenViewModel();

  @override
  void initState() {
    super.initState();
    paymentsScreenViewModel.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => paymentsScreenViewModel,
      child: Consumer<PaymentsScreenViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: AppColor.appWhiteColor,
            appBar: AppBar(
              backgroundColor: AppColor.appWhiteColor,
              leading: CustomTextButton(
                onPressed: () {
                  viewModel.goToHomeScreen();
                },
                child: Icon(
                  Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              title: ResponsiveText(
                text: "Payments",
                style: Fonts.regularTextStyleBold.copyWith(
                    fontSize: fontSize_16
                ),
              ),
              centerTitle: true,
            ),
            body: ListView.separated(
              itemCount: 20,
              shrinkWrap: true,
              padding: EdgeInsets.all(padding_18),
              separatorBuilder: (context, index) => CommonWidget.getFieldSpacer(height: padding_10),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    NavigatorHelper().add(OrderDetailScreen(isPick: false,isDelivery: true,));
                  },
                  child: Card(
                    elevation: 1,
                    color: AppColor.appWhiteColor,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(padding_04)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(padding_08),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(padding_04),
                                decoration: BoxDecoration(
                                    color: AppColor.appPrimaryColor.withValues(alpha: 0.4),
                                    shape: BoxShape.circle
                                ),
                                child: Icon(Icons.person,color: AppColor.appWhiteColor,size: padding_30,),
                              ),
                              CommonWidget.getFieldSpacer(width: padding_12),
                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ResponsiveText(
                                        text: "#855152635",
                                        style: Fonts.regularTextStyleBold,
                                      ),
                                      ResponsiveText(
                                        text: "AED 128",
                                        style: Fonts.regularTextStyleBold,
                                      ),
                                    ],
                                  ),
                                  ResponsiveText(
                                    text: "Customer Name",
                                    style: Fonts.regularTextStyle.copyWith(
                                        color: Colors.grey
                                    ),
                                  ),

                                ],
                              ),),
                            ],
                          ),
                          ResponsiveText(
                            text: "123 Main Street New York, NY 10001",
                            style: Fonts.regularTextStyle,
                            maxLines: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Status",style: Fonts.regularTextStyle.copyWith(
                                      color: Colors.grey
                                  ),),
                                  Text("Delivery",style: Fonts.regularTextStyleMedium.copyWith(
                                      color: Colors.green
                                  ),),
                                ],
                              ),),
                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Status",style: Fonts.regularTextStyle.copyWith(
                                      color: Colors.grey
                                  ),),
                                  Text(index.isEven?"Pending":"Paid",style: Fonts.regularTextStyleMedium.copyWith(
                                      color: index.isEven?Colors.blue:Colors.green
                                  ),),
                                ],
                              ),),
                            ],
                          ),
                          CommonWidget.getFieldSpacer(height: padding_04),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("23 Jun 2025,11:50 AM",style: Fonts.regularTextStyle.copyWith(
                                  color: Colors.grey
                              ),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

