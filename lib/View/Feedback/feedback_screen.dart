import 'dart:io';

import 'package:driver/Utils/common_widget.dart';
import 'package:driver/View/Feedback/feedback_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Custom/custom_text_button.dart';
import '../../Custom/responsive_text.dart';
import '../../Helper/navigation_helper.dart';
import '../../Style/Fonts.dart';
import '../../Style/app_theme.dart';
import '../../Utils/Constants.dart';
class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {

  FeedbackScreenViewModel feedbackScreenViewModel = FeedbackScreenViewModel();

  @override
  void initState() {
    super.initState();
    feedbackScreenViewModel.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => feedbackScreenViewModel,
      child: Consumer<FeedbackScreenViewModel>(
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
                text: "Feedback",
                style: Fonts.regularTextStyleBold.copyWith(
                  fontSize: fontSize_16,
                  color: AppColor.appWhiteColor,
                ),
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
            ),
            body: ListView.separated(
              padding: EdgeInsets.all(padding_20),
              shrinkWrap: true,
              itemCount: 8,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.appPrimaryColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(padding_04)
                          ),
                          child: Icon(Icons.person_2_outlined,size: padding_30,color: AppColor.appPrimaryColor,),
                        ),
                        CommonWidget.getFieldSpacer(width: padding_12),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Allison Dorwart",style: Fonts.regularTextStyleBold,),
                            CommonWidget.getFieldSpacer(height: padding_04),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.star,color: Colors.orangeAccent,size: padding_20,),
                                    Icon(Icons.star,color: Colors.orangeAccent,size: padding_20,),
                                    Icon(Icons.star,color: Colors.orangeAccent,size: padding_20,),
                                    Icon(Icons.star,color: Colors.orangeAccent,size: padding_20,),
                                    Icon(Icons.star,color: Colors.orangeAccent,size: padding_20,),
                                    CommonWidget.getFieldSpacer(width: padding_12),
                                    Text("5.0",style: Fonts.regularTextStyle.copyWith(fontSize: fontSize_12),)
                                  ],
                                ),
                                Text("19 May 2025",style: Fonts.regularTextStyle.copyWith(
                                  fontSize: fontSize_12
                                ),)
                              ],
                            )
                          ],
                        ),),
                      ],
                    ),
                    ResponsiveText(
                      text: 'The driver arrived on time and was very polite throughout the journey. The vehicle was clean and comfortable. He followed all traffic rules and ensured a smooth ride. Communication was clear, and he handled the delivery efficiently. Would definitely recommend!',
                      style: Fonts.regularTextStyle,
                      maxLines: 15,
                      textAlign: TextAlign.start,
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
