import 'dart:io';

import 'package:driver/Utils/common_widget.dart';
import 'package:driver/View/Earning/earning_screen_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Custom/custom_text_button.dart';
import '../../Custom/responsive_text.dart';
import '../../Helper/navigation_helper.dart';
import '../../Style/Fonts.dart';
import '../../Style/app_theme.dart';
import '../../Utils/Constants.dart';

class EarningScreen extends StatefulWidget {
  const EarningScreen({super.key});

  @override
  State<EarningScreen> createState() => _EarningScreenState();
}

class _EarningScreenState extends State<EarningScreen> {
  EarningScreenViewModel earningScreenViewModel = EarningScreenViewModel();

  @override
  void initState() {
    super.initState();
    earningScreenViewModel.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => earningScreenViewModel,
      child: Consumer<EarningScreenViewModel>(
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
                text: "Earning",
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
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(padding_12),
                          decoration: BoxDecoration(
                            color: AppColor.appPrimaryColor,
                            borderRadius: BorderRadius.circular(padding_04),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.currency_exchange,
                                color: AppColor.appWhiteColor,
                              ),
                              Text(
                                "\$85.0",
                                style: Fonts.regularTextStyleExtraBold.copyWith(
                                  color: AppColor.appWhiteColor,
                                  fontSize: fontSize_20,
                                ),
                              ),
                              Text(
                                "Today's Earning",
                                style: Fonts.regularTextStyleBold.copyWith(
                                  color: AppColor.appWhiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CommonWidget.getFieldSpacer(width: padding_16),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(padding_12),
                          decoration: BoxDecoration(
                            color: AppColor.appPrimaryColor,
                            borderRadius: BorderRadius.circular(padding_04),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.currency_exchange,
                                color: AppColor.appWhiteColor,
                              ),
                              Text(
                                "\$85.0",
                                style: Fonts.regularTextStyleExtraBold.copyWith(
                                  color: AppColor.appWhiteColor,
                                  fontSize: fontSize_20,
                                ),
                              ),
                              Text(
                                "This Week",
                                style: Fonts.regularTextStyleBold.copyWith(
                                  color: AppColor.appWhiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  CommonWidget.getFieldSpacer(height: padding_16),
                  Text(
                    "Transaction",
                    style: Fonts.regularTextStyleBold.copyWith(
                      fontSize: fontSize_16,
                    ),
                  ),
                  CommonWidget.getFieldSpacer(height: padding_10),
                  ListView.separated(
                    itemCount: 15,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => Divider(color: CupertinoColors.systemGrey4,),
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      index.isEven ? "UPI" : "Cash",
                                      style: Fonts.regularTextStyleMedium,
                                    ),

                                  ],
                                ),
                                Text(
                                  index.isEven ? "UPI202507130001" : "-",
                                  style: Fonts.regularTextStyle.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                                Text("12 July,2025",style: Fonts.regularTextStyle)
                              ],
                            ),
                          ),
                          Text("\$12.0",style: Fonts.regularTextStyleMedium,),
                          CommonWidget.getFieldSpacer(width: padding_12),
                          Transform.rotate(
                            angle: 180 * 3.1415927 / 180,
                            // angle in radians (e.g., 90 degrees)
                            child: Icon(Icons.open_in_new, color: Colors.green),
                          ),
                        ],
                      );
                      // return ListTile(
                      //   contentPadding: EdgeInsets.zero,
                      //   visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                      //   title: Text(index.isEven?"UPI":"Cash",style: Fonts.regularTextStyleMedium,),
                      //   subtitle: Text(index.isEven?"UPI202507130001":"-",style: Fonts.regularTextStyle.copyWith(
                      //     color: Colors.grey
                      //   ),),
                      //   trailing: Transform.rotate(
                      //       angle: 180 * 3.1415927 / 180, // angle in radians (e.g., 90 degrees)
                      //       child: Icon(Icons.open_in_new,color: Colors.green,)),
                      // );
                    },
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
