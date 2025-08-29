import 'dart:io';

import 'package:driver/Utils/app_global.dart';
import 'package:driver/View/BottomNavigationBar/bottom_navigation_bar_screen_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../Custom/custom_text_button.dart';
import '../../Custom/responsive_text.dart';
import '../../Helper/assets_helper.dart';
import '../../Style/Fonts.dart';
import '../../Style/app_theme.dart';
import '../../Utils/common_widget.dart';
class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {

  BottomNavigationBarScreenViewModel bottomNavigationBarScreenViewModel = BottomNavigationBarScreenViewModel();

  @override
  void initState() {
    super.initState();
    bottomNavigationBarScreenViewModel.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AppGlobal.bottomNavigationIndex,
      builder: (context, value, child) {
        return ChangeNotifierProvider(
          create: (context) => bottomNavigationBarScreenViewModel,
          child: Consumer<BottomNavigationBarScreenViewModel>(
            builder: (context, viewModel, child) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                bottomNavigationBar: SafeArea(child: buildBottomNavigation(AppGlobal.isShowBottomNav.value)),
                  body: PageView(
                    controller: viewModel.pageController,
                    pageSnapping: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollBehavior: const CupertinoScrollBehavior(),
                    children: viewModel.bottomNavScreenList,
                    onPageChanged: (index) {
                      // viewModel.update();
                    },
                  )
              );
            },
          ),
        );
      },
    );
  }

  ChangeNotifierProvider<BottomNavigationBarScreenViewModel> buildBottomNavigation(bool isShowBottomNav) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => bottomNavigationBarScreenViewModel,
      child: Consumer<BottomNavigationBarScreenViewModel>(
        builder: (context, viewModel, _) {
          return ValueListenableBuilder(
            valueListenable: AppGlobal.isShowBottomNav,
            builder: (context, value, child) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: (AppGlobal.hasNotch(context) && Platform.isIOS) ? 75 : 65,
                decoration: BoxDecoration(
                  color: AppColor.appWhiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 3.0,
                      spreadRadius: 0.0,
                      offset: const Offset(0.0, -3.0),
                    )
                  ],
                ),
                child: Container(
                  margin: EdgeInsets.only(bottom: AppGlobal.hasNotch(context) ? 15 : 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: CustomTextButton(
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    AssetsHelper.getSVGIcon('ic_home.svg'),
                                    height: 24,
                                    colorFilter: ColorFilter.mode(
                                        AppGlobal.bottomNavigationIndexVal.value == 0 ? AppColor.appPrimaryColor : Colors.grey,
                                        BlendMode.srcIn
                                    ),
                                  ),
                                  CommonWidget.getFieldSpacer(height: 5),
                                  ResponsiveText(
                                    text: "Home",
                                    style: Fonts.regularTextStyleMedium.copyWith(
                                        color: AppGlobal.bottomNavigationIndexVal.value == 0 ? AppColor.appPrimaryColor : Colors.grey,
                                        fontSize: 12
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                viewModel.changeIndex(0, false);
                              },
                            ),
                          ),
                          Expanded(
                            child: CustomTextButton(
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    AssetsHelper.getSVGIcon('ic_order.svg'),
                                    height: 24,
                                    colorFilter: ColorFilter.mode(
                                        AppGlobal.bottomNavigationIndexVal.value == 1 ? AppColor.appPrimaryColor : Colors.grey,
                                        BlendMode.srcIn
                                    ),
                                  ),
                                  CommonWidget.getFieldSpacer(height: 5),
                                  ResponsiveText(
                                    text: "Orders",
                                    style: Fonts.regularTextStyleMedium.copyWith(
                                        color: AppGlobal.bottomNavigationIndexVal.value == 1 ? AppColor.appPrimaryColor : Colors.grey,
                                        fontSize: 12
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                viewModel.changeIndex(1, false);
                              },
                            ),
                          ),
                          Expanded(
                            child: CustomTextButton(
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    AssetsHelper.getSVGIcon('ic_payments.svg'),
                                    height: 24,
                                    colorFilter: ColorFilter.mode(
                                        AppGlobal.bottomNavigationIndexVal.value == 2 ? AppColor.appPrimaryColor : Colors.grey,
                                        BlendMode.srcIn
                                    ),
                                  ),
                                  CommonWidget.getFieldSpacer(height: 5),
                                  ResponsiveText(
                                    text: "Payments",
                                    style: Fonts.regularTextStyleMedium.copyWith(
                                        color: AppGlobal.bottomNavigationIndexVal.value == 2 ? AppColor.appPrimaryColor : Colors.grey,
                                        fontSize: 12
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                viewModel.changeIndex(2, false);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
