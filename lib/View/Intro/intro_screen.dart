import 'package:driver/Helper/assets_helper.dart';
import 'package:driver/Style/app_theme.dart';
import 'package:driver/Style/fonts.dart';
import 'package:driver/Utils/common_widget.dart';
import 'package:driver/Utils/constants.dart';
import 'package:driver/View/Intro/intro_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  IntroScreenViewModel introScreenViewModel = IntroScreenViewModel();

  @override
  void initState() {
    super.initState();
    introScreenViewModel.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => introScreenViewModel,
      child: Consumer<IntroScreenViewModel>(
        builder: (context, viewModel, child){
          return Scaffold(
            body: Stack(
              children: [
                PageView.builder(
                  controller: viewModel.pageController,
                  itemCount: viewModel.allItems.length,
                  onPageChanged: (value) {
                    viewModel.changePage(value);
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height*0.2,
                          width: MediaQuery.of(context).size.width,
                          color: AppColor.appPrimaryColor,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height*0.35,
                          width: MediaQuery.of(context).size.width,
                          color: AppColor.appWhiteColor,
                          child: AssetsHelper.getAssetImage(name: viewModel.allItems[index].image,height: MediaQuery.of(context).size.height*0.3,fit: BoxFit.fill),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height*0.45,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(20),
                          color: AppColor.appPrimaryColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(viewModel.allItems[index].title,style: Fonts.regularTextStyle.copyWith(
                                color: AppColor.appWhiteColor,
                                fontSize: fontSize_16
                              ),),
                              CommonWidget.getFieldSpacer(height: padding_04),
                              Text(viewModel.allItems[index].subTitle,style: Fonts.regularTextStyleBold.copyWith(
                                color: AppColor.appWhiteColor,
                                fontSize: fontSize_22
                              ),),
                              CommonWidget.getFieldSpacer(height: padding_12),
                              Text(viewModel.allItems[index].description,style: Fonts.regularTextStyle.copyWith(
                                color: AppColor.appWhiteColor,
                                fontSize: fontSize_16
                              ),
                              textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
                Positioned(
                  bottom: 30,
                  left: 20,
                  right: 20,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Page Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(onPressed: viewModel.currentPage!=2?(){
                            viewModel.navigationToLogin();
                          }:null, child: Text("Skip",style: Fonts.regularTextStyle.copyWith(
                            color: viewModel.currentPage!=2?AppColor.appWhiteColor:AppColor.appPrimaryColor
                          ),)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              viewModel.allItems.length,
                                  (index) => Container(
                                margin: EdgeInsets.symmetric(horizontal: 4.0),
                                width: 10.0,
                                height: 8.0,
                                decoration: BoxDecoration(
                                  color: viewModel.currentPage == index
                                      ? AppColor.appWhiteColor
                                      : Colors.grey.shade700,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                          TextButton(onPressed: (){
                            if(viewModel.currentPage!=2){
                              viewModel.changePage(viewModel.currentPage+1);
                              viewModel.changeTab();
                            }
                            else{
                              viewModel.navigationToLogin();
                            }
                          }, child: Text(viewModel.currentPage==2?"Start":"Next",style: Fonts.regularTextStyle.copyWith(
                            color: AppColor.appWhiteColor
                          ),)),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
