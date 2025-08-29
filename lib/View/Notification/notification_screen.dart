import 'dart:io';

import 'package:driver/Utils/common_widget.dart';
import 'package:driver/View/Notification/notification_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Custom/custom_text_button.dart';
import '../../Custom/responsive_text.dart';
import '../../Helper/navigation_helper.dart';
import '../../Style/Fonts.dart';
import '../../Style/app_theme.dart';
import '../../Utils/Constants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationScreenViewModel notificationScreenViewModel =
      NotificationScreenViewModel();

  @override
  void initState() {
    super.initState();
    notificationScreenViewModel.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => notificationScreenViewModel,
      child: Consumer<NotificationScreenViewModel>(
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
                text: "Notification",
                style: Fonts.regularTextStyleBold.copyWith(
                  fontSize: fontSize_16,
                  color: AppColor.appWhiteColor,
                ),
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
            ),
            body: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.all(padding_20),
              itemCount: viewModel.notificationList.length,
              separatorBuilder:
                  (context, index) =>
                      CommonWidget.getFieldSpacer(height: padding_20),
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(padding_04),
                      decoration: BoxDecoration(
                        color: AppColor.appPrimaryColor,
                        borderRadius: BorderRadius.circular(padding_04),
                      ),
                      child: Icon(Icons.notifications,color: AppColor.appWhiteColor,),
                    ),
                    CommonWidget.getFieldSpacer(width: padding_12),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ResponsiveText(
                          text: viewModel.notificationList[index].title,
                          style: Fonts.regularTextStyleMedium,
                          maxLines: 2,
                        ),
                        ResponsiveText(
                          text: viewModel.notificationList[index].description,
                          style: Fonts.regularTextStyle.copyWith(
                            color: Colors.grey,
                            fontSize: fontSize_12
                          ),
                          maxLines: 4,
                          textAlign: TextAlign.start,
                        )
                      ],
                    ),),
                  ],
                );
                // return ListTile(
                //   contentPadding: EdgeInsets.zero,
                //   visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                //   title: Text(viewModel.notificationList[index].title,style: Fonts.regularTextStyleMedium.copyWith(
                //     fontSize: fontSize_16
                //   ),),
                //   subtitle: Text(viewModel.notificationList[index].description),
                //   leading: Container(
                //     padding: EdgeInsets.all(padding_04),
                //     decoration: BoxDecoration(
                //       color: AppColor.appPrimaryColor,
                //       borderRadius: BorderRadius.circular(padding_04)
                //     ),
                //     child: Icon(Icons.notifications,color: AppColor.appWhiteColor,),
                //   ),
                // );
              },
            ),
          );
        },
      ),
    );
  }
}
