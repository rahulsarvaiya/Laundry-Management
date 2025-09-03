import 'package:driver/Custom/button_view.dart';
import 'package:driver/Custom/custom_text_button.dart';
import 'package:driver/Custom/responsive_text.dart';
import 'package:driver/Helper/assets_helper.dart';
import 'package:driver/Helper/navigation_helper.dart';
import 'package:driver/Helper/pref_name.dart';
import 'package:driver/Style/Fonts.dart';
import 'package:driver/Style/app_theme.dart';
import 'package:driver/Utils/app_global.dart';
import 'package:driver/Utils/common_widget.dart';
import 'package:driver/Utils/constants.dart';
import 'package:driver/View/Dashboard/dashboard_screen_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Helper/preference.dart';
import '../Earning/earning_screen.dart';
import '../Feedback/feedback_screen.dart';
import '../LoadeDelivery/delivery_load_screen.dart';
import '../Notification/notification_screen.dart';
import '../OrderDetail/order_detail_screen.dart';
import '../PrivacyPolicy/privacy_policy_screen.dart';
import '../TermsAndCondition/terms_and_condition_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardScreenViewModel dashboardScreenViewModel =
      DashboardScreenViewModel();

  @override
  void initState() {
    super.initState();
    dashboardScreenViewModel.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => dashboardScreenViewModel,
      child: Consumer<DashboardScreenViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            key: viewModel.scaffoldKey,
            backgroundColor: AppColor.appWhiteColor,
            appBar: AppBar(
              backgroundColor: AppColor.appWhiteColor,
              leading: IconButton(onPressed: (){
                viewModel.scaffoldKey.currentState?.openDrawer();
              }, icon: Icon(Icons.menu,color: AppColor.appPrimaryColor,)),
              title: AssetsHelper.getAssetImage(name: "app_drawer.png"),
              centerTitle: true,
              // leadingWidth: 180,
              // leading: AssetsHelper.getAssetImage(name: "app_logo_light.jpeg"),
              // title: AppGlobal.isOnline.value?Row(
              //   children: [
              //     Icon(Icons.location_on_outlined,size: padding_22,color: Colors.green,),
              //     Text("You are online",style: Fonts.regularTextStyleMedium.copyWith(
              //         color: Colors.green
              //     ),)
              //   ],
              // ):Row(
              //   children: [
              //     Icon(Icons.location_off_outlined,size: padding_22,color: Colors.red,),
              //     Text("You are offline",style: Fonts.regularTextStyle.copyWith(
              //       color: Colors.red
              //     ),)
              //   ],
              // ),
              actions: [
                ValueListenableBuilder(
                  valueListenable: AppGlobal.isOnline,
                  builder: (context, value, child) => CustomTextButton(
                        onPressed: () {
                          viewModel.changeOnlineStatus();
                        },
                        child: Container(
                          padding: EdgeInsets.all(padding_04),
                          decoration: BoxDecoration(
                            color: AppGlobal.isOnline.value?Colors.red:Colors.green,
                            borderRadius: BorderRadius.circular(padding_04),
                          ),
                          child: Text(
                            AppGlobal.isOnline.value ? "Offline" : "Go online",
                            style: Fonts.regularTextStyleMedium.copyWith(
                              color: AppColor.appWhiteColor,
                            ),
                          ),
                        ),
                      ),
                ),
                CustomTextButton(
                  onPressed: () {
                    NavigatorHelper().add(NotificationScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.appPrimaryColor,
                      borderRadius: BorderRadius.circular(padding_04),
                    ),
                    padding: EdgeInsets.all(padding_04),
                    child: Icon(
                      Icons.notifications,
                      color: AppColor.appWhiteColor,
                      size: padding_20,
                    ),
                  ),
                ),
                CommonWidget.getFieldSpacer(width: padding_16)
              ],
            ),
            body: Visibility(
              visible: viewModel.loader.value,
              replacement: SingleChildScrollView(
                padding: EdgeInsets.only(left: padding_18,right: padding_18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResponsiveText(
                      text: 'Pending payment',
                      style: Fonts.regularTextStyleBold.copyWith(
                          fontSize: fontSize_18
                      ),
                    ),
                    CommonWidget.getFieldSpacer(height: padding_04),
                    Container(
                      padding: EdgeInsets.all(padding_10),
                      decoration: BoxDecoration(
                          color: AppColor.appPrimaryColor,
                          borderRadius: BorderRadius.circular(padding_04)
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.wallet,color: AppColor.appWhiteColor,size: padding_30,),
                              CommonWidget.getFieldSpacer(width: padding_12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Balance",style: Fonts.regularTextStyle.copyWith(
                                    color: AppColor.appWhiteColor,
                                  ),),
                                  CommonWidget.getFieldSpacer(height: padding_04),
                                  Text(viewModel.dashboardResult?.totalAmount??"0",style: Fonts.regularTextStyleMedium.copyWith(
                                    color: AppColor.appWhiteColor,
                                    fontSize: fontSize_22,
                                  ),)
                                ],
                              )
                            ],
                          ),
                          // CommonWidget.getFieldSpacer(height: padding_04),
                          // IntrinsicHeight(
                          //   child: Row(
                          //     children: [
                          //       Expanded(child: Column(
                          //         children: [
                          //           Text("Today",style: Fonts.regularTextStyle.copyWith(
                          //               color: AppColor.appWhiteColor,
                          //               fontSize: fontSize_12
                          //           ),),
                          //           Text("\$${0.0}",style: Fonts.regularTextStyleMedium.copyWith(
                          //             color: AppColor.appWhiteColor,
                          //             fontSize: fontSize_12
                          //           ),),
                          //         ],
                          //       ),),
                          //       VerticalDivider(color: AppColor.appWhiteColor,thickness: 1,width: 1,),
                          //       Expanded(child: Column(
                          //         children: [
                          //           Text("This week",style: Fonts.regularTextStyle.copyWith(
                          //               color: AppColor.appWhiteColor,
                          //               fontSize: fontSize_12
                          //           ),),
                          //           Text("\$${8.0}",style: Fonts.regularTextStyleMedium.copyWith(
                          //               color: AppColor.appWhiteColor,
                          //               fontSize: fontSize_12
                          //           ),),
                          //         ],
                          //       ),),
                          //       VerticalDivider(color: AppColor.appWhiteColor,thickness: 1,width: 1,),
                          //       Expanded(child: Column(
                          //         children: [
                          //           Text("This month",style: Fonts.regularTextStyle.copyWith(
                          //             color: AppColor.appWhiteColor,
                          //             fontSize: fontSize_12
                          //           ),),
                          //           Text("\$${0.0}",style: Fonts.regularTextStyleMedium.copyWith(
                          //               color: AppColor.appWhiteColor,
                          //               fontSize: fontSize_12
                          //           ),),
                          //         ],
                          //       ),),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    CommonWidget.getFieldSpacer(height: padding_10),

                    ///order status
                    ResponsiveText(
                      text: 'Order Status',
                      style: Fonts.regularTextStyleBold.copyWith(
                          fontSize: fontSize_18
                      ),
                    ),
                    CommonWidget.getFieldSpacer(height: padding_04),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(padding_10),
                            decoration: BoxDecoration(
                                color: Color(0xFFFFC107),
                                borderRadius: BorderRadius.circular(padding_04)
                            ),
                            child: Column(
                              children: [
                                ResponsiveText(
                                  text: "${viewModel.dashboardResult?.pickupRemaining??0}/${viewModel.dashboardResult?.totalPickup??0}",
                                  style: Fonts.regularTextStyleExtraBold.copyWith(
                                      fontSize: fontSize_22,
                                      color: AppColor.appWhiteColor
                                  ),
                                ),
                                ResponsiveText(
                                  text: "Pickup",
                                  style: Fonts.regularTextStyleBold.copyWith(
                                      fontSize: fontSize_16,
                                      color: AppColor.appWhiteColor
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        CommonWidget.getFieldSpacer(width: padding_12),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(padding_10),
                            decoration: BoxDecoration(
                                color: Color(0xFF4CAF50),
                                borderRadius: BorderRadius.circular(padding_04)
                            ),
                            child: Column(
                              children: [
                                ResponsiveText(
                                  text: "${viewModel.dashboardResult?.deliveryRemaining??0}/${viewModel.dashboardResult?.totalDelivery??0}",
                                  style: Fonts.regularTextStyleExtraBold.copyWith(
                                      fontSize: fontSize_22,
                                      color: AppColor.appWhiteColor
                                  ),
                                ),
                                ResponsiveText(
                                  text: "Delivery",
                                  style: Fonts.regularTextStyleBold.copyWith(
                                      fontSize: fontSize_16,
                                      color: AppColor.appWhiteColor
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    CommonWidget.getFieldSpacer(height: padding_12),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(padding_10),
                            decoration: BoxDecoration(
                                color: Color(0xFF2196F3),
                                borderRadius: BorderRadius.circular(padding_04)
                            ),
                            child: Column(
                              children: [
                                ResponsiveText(
                                  text: "${viewModel.dashboardResult?.paymentRemainCollect??0}/${viewModel.dashboardResult?.totalPayment??0}",
                                  style: Fonts.regularTextStyleExtraBold.copyWith(
                                      fontSize: fontSize_22,
                                      color: AppColor.appWhiteColor
                                  ),
                                ),
                                ResponsiveText(
                                  text: "Payments",
                                  style: Fonts.regularTextStyleBold.copyWith(
                                      fontSize: fontSize_16,
                                      color: AppColor.appWhiteColor
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    CommonWidget.getFieldSpacer(height: padding_10),

                    // ///summary
                    // ResponsiveText(
                    //   text: 'Order Summary',
                    //   style: Fonts.regularTextStyleBold.copyWith(
                    //       fontSize: fontSize_18
                    //   ),
                    // ),
                    // CommonWidget.getFieldSpacer(height: padding_04),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Container(
                    //         padding: EdgeInsets.all(padding_10),
                    //         decoration: BoxDecoration(
                    //           color: AppColor.appPrimaryColor,
                    //           borderRadius: BorderRadius.circular(padding_04)
                    //         ),
                    //         child: Column(
                    //           children: [
                    //             ResponsiveText(
                    //               text: "0",
                    //               style: Fonts.regularTextStyleExtraBold.copyWith(
                    //                 fontSize: fontSize_22,
                    //                 color: AppColor.appWhiteColor
                    //               ),
                    //             ),
                    //             ResponsiveText(
                    //               text: "Today",
                    //               style: Fonts.regularTextStyleBold.copyWith(
                    //                   fontSize: fontSize_16,
                    //                   color: AppColor.appWhiteColor
                    //               ),
                    //             ),
                    //             ResponsiveText(
                    //               text: "Orders",
                    //               style: Fonts.regularTextStyle.copyWith(
                    //                   fontSize: fontSize_12,
                    //                   color: AppColor.appWhiteColor
                    //               ),
                    //             ),
                    //
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     CommonWidget.getFieldSpacer(width: padding_12),
                    //     Expanded(
                    //       child: Container(
                    //         padding: EdgeInsets.all(padding_10),
                    //         decoration: BoxDecoration(
                    //           color: AppColor.appPrimaryColor,
                    //           borderRadius: BorderRadius.circular(padding_04)
                    //         ),
                    //         child: Column(
                    //           children: [
                    //             ResponsiveText(
                    //               text: "2",
                    //               style: Fonts.regularTextStyleExtraBold.copyWith(
                    //                 fontSize: fontSize_22,
                    //                 color: AppColor.appWhiteColor
                    //               ),
                    //             ),
                    //             ResponsiveText(
                    //               text: "This Week",
                    //               style: Fonts.regularTextStyleBold.copyWith(
                    //                   fontSize: fontSize_16,
                    //                   color: AppColor.appWhiteColor
                    //               ),
                    //             ),
                    //             ResponsiveText(
                    //               text: "Orders",
                    //               style: Fonts.regularTextStyle.copyWith(
                    //                   fontSize: fontSize_12,
                    //                   color: AppColor.appWhiteColor
                    //               ),
                    //             ),
                    //
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // CommonWidget.getFieldSpacer(height: padding_12),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Container(
                    //         padding: EdgeInsets.all(padding_10),
                    //         decoration: BoxDecoration(
                    //           color: AppColor.appPrimaryColor,
                    //           borderRadius: BorderRadius.circular(padding_04)
                    //         ),
                    //         child: Column(
                    //           children: [
                    //             ResponsiveText(
                    //               text: "5",
                    //               style: Fonts.regularTextStyleExtraBold.copyWith(
                    //                 fontSize: fontSize_22,
                    //                 color: AppColor.appWhiteColor
                    //               ),
                    //             ),
                    //             ResponsiveText(
                    //               text: "This Month",
                    //               style: Fonts.regularTextStyleBold.copyWith(
                    //                   fontSize: fontSize_16,
                    //                   color: AppColor.appWhiteColor
                    //               ),
                    //             ),
                    //             ResponsiveText(
                    //               text: "Orders",
                    //               style: Fonts.regularTextStyle.copyWith(
                    //                   fontSize: fontSize_12,
                    //                   color: AppColor.appWhiteColor
                    //               ),
                    //             ),
                    //
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     CommonWidget.getFieldSpacer(width: padding_12),
                    //     Expanded(
                    //       child: Container(
                    //         padding: EdgeInsets.all(padding_10),
                    //         decoration: BoxDecoration(
                    //           color: AppColor.appPrimaryColor,
                    //           borderRadius: BorderRadius.circular(padding_04)
                    //         ),
                    //         child: Column(
                    //           children: [
                    //             ResponsiveText(
                    //               text: "8",
                    //               style: Fonts.regularTextStyleExtraBold.copyWith(
                    //                 fontSize: fontSize_22,
                    //                 color: AppColor.appWhiteColor
                    //               ),
                    //             ),
                    //             ResponsiveText(
                    //               text: "This Year",
                    //               style: Fonts.regularTextStyleBold.copyWith(
                    //                   fontSize: fontSize_16,
                    //                   color: AppColor.appWhiteColor
                    //               ),
                    //             ),
                    //             ResponsiveText(
                    //               text: "Orders",
                    //               style: Fonts.regularTextStyle.copyWith(
                    //                   fontSize: fontSize_12,
                    //                   color: AppColor.appWhiteColor
                    //               ),
                    //             ),
                    //
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // CommonWidget.getFieldSpacer(height: padding_10),

                    ///routes
                    ResponsiveText(
                      text: 'Routes',
                      style: Fonts.regularTextStyleBold.copyWith(
                          fontSize: fontSize_18
                      ),
                    ),
                    (viewModel.dashboardResult != null && viewModel.dashboardResult!.routes!.isEmpty)?Center(child: Text("No routes",style: Fonts.regularTextStyleMedium,),):ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: viewModel.dashboardResult?.routes?.length??0,
                      separatorBuilder: (context, index) => CommonWidget.getFieldSpacer(height: padding_12),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding: EdgeInsets.all(padding_04),
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlueAccent.withValues(alpha: 0.2),
                                        shape: BoxShape.circle
                                    ),
                                    child: Icon(Icons.location_on,color: AppColor.appPrimaryColor.withValues(alpha: 0.8),size: padding_20,)),
                                CommonWidget.getFieldSpacer(width: padding_12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(viewModel.dashboardResult?.routes?[index].name??"",style: Fonts.regularTextStyleMedium.copyWith(
                                        fontSize: fontSize_16,
                                      ),),
                                      CommonWidget.getFieldSpacer(height: padding_06),
                                      viewModel.dashboardResult?.dashboardDisplayOrder!=null?SizedBox():Row(
                                        children: [
                                          Expanded(
                                            child: ButtonView(
                                              buttonTextName: "Load Delivery",
                                              onPressed: (){
                                                NavigatorHelper().add(DeliveryLoadScreen(),callback: (value){
                                                  if(value!=null && value==true){
                                                    viewModel.changeDeliveryLoad(value);
                                                  }
                                                });
                                              },
                                              height: 35,
                                              color: viewModel.deliveryLoaded?AppColor.appPrimaryColor.withValues(alpha: 0.5):AppColor.appPrimaryColor,
                                              borderColor: viewModel.deliveryLoaded?AppColor.appPrimaryColor.withValues(alpha: 0.5):AppColor.appPrimaryColor,
                                            ),
                                          ),
                                          CommonWidget.getFieldSpacer(width: padding_20),
                                          Expanded(
                                            child: ButtonView(
                                              onPressed: (){
                                                if(viewModel.deliveryLoaded){
                                                  AppGlobal.bottomNavigationIndex.value =1;
                                                }
                                              },
                                              buttonTextName: "Start",
                                              height: 35,
                                              width: MediaQuery.of(context).size.width,
                                              color: viewModel.deliveryLoaded?AppColor.appPrimaryColor:AppColor.appPrimaryColor.withValues(alpha: 0.5),
                                              borderColor: viewModel.deliveryLoaded?AppColor.appPrimaryColor:Colors.transparent,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                //   Radio(
                                //   value: viewModel.allRoutes[index].value,
                                //   groupValue: viewModel.selectedRoutes,
                                //   onChanged: (value) {
                                //     viewModel.changeRoute(value!);
                                //   },
                                // )
                              ],
                            )
                          ],
                        );
                        // return RadioListTile(
                        //   value: viewModel.allRoutes[index].value,
                        //   groupValue: viewModel.selectedRoutes,
                        //   onChanged: (value) {
                        //     viewModel.changeRoute(value!);
                        //   },
                        //   title: Text(viewModel.allRoutes[index].name,style: Fonts.regularTextStyleMedium.copyWith(
                        //         fontSize: fontSize_16
                        //       ),),
                        //   subtitle:ListView.builder(
                        //         shrinkWrap: true,
                        //         physics: NeverScrollableScrollPhysics(),
                        //         itemCount: viewModel.allRoutes[index].routes.length,
                        //         itemBuilder: (context, cIndex) {
                        //           Routes item = viewModel.allRoutes[index].routes[cIndex];
                        //           return RadioListTile(
                        //             contentPadding: EdgeInsets.zero,
                        //             visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                        //             value: item.value,
                        //             groupValue: viewModel.selectedRoutes,
                        //             controlAffinity: ListTileControlAffinity.trailing,
                        //             hoverColor: Colors.transparent,
                        //             secondary: Container(
                        //                 padding: EdgeInsets.all(padding_04),
                        //                 decoration: BoxDecoration(
                        //                     color: Colors.lightBlueAccent.withValues(alpha: 0.2),
                        //                     shape: BoxShape.circle
                        //                 ),
                        //                 child: Icon(Icons.location_on,color: AppColor.appPrimaryColor.withValues(alpha: 0.8),size: padding_20,)),
                        //             title: ResponsiveText(
                        //               text: item.address,
                        //               style: Fonts.regularTextStyle.copyWith(
                        //                 color: Colors.grey
                        //               ),
                        //               textAlign: TextAlign.start,
                        //             ),
                        //             onChanged: (value){
                        //               viewModel.changeRoute(value!);
                        //             },
                        //             splashRadius: 0,
                        //           );
                        //         },
                        //       ),
                        //   controlAffinity: ListTileControlAffinity.trailing,
                        //
                        // );
                        // return Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(viewModel.allRoutes[index].name,style: Fonts.regularTextStyleMedium.copyWith(
                        //       fontSize: fontSize_16
                        //     ),),
                        //     ListView.builder(
                        //       shrinkWrap: true,
                        //       physics: NeverScrollableScrollPhysics(),
                        //       itemCount: viewModel.allRoutes[index].routes.length,
                        //       itemBuilder: (context, cIndex) {
                        //         Routes item = viewModel.allRoutes[index].routes[cIndex];
                        //         return RadioListTile(
                        //           contentPadding: EdgeInsets.zero,
                        //           visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                        //           value: item.value,
                        //           groupValue: viewModel.selectedRoutes,
                        //           controlAffinity: ListTileControlAffinity.trailing,
                        //           hoverColor: Colors.transparent,
                        //           secondary: Container(
                        //               padding: EdgeInsets.all(padding_04),
                        //               decoration: BoxDecoration(
                        //                   color: Colors.lightBlueAccent.withValues(alpha: 0.2),
                        //                   shape: BoxShape.circle
                        //               ),
                        //               child: Icon(Icons.location_on,color: AppColor.appPrimaryColor.withValues(alpha: 0.8),size: padding_20,)),
                        //           title: ResponsiveText(
                        //             text: item.address,
                        //             style: Fonts.regularTextStyle.copyWith(
                        //               color: Colors.grey
                        //             ),
                        //             textAlign: TextAlign.start,
                        //           ),
                        //           onChanged: (value){
                        //             viewModel.changeRoute(value!);
                        //           },
                        //           splashRadius: 0,
                        //         );
                        //       },
                        //     ),
                        //   ],
                        // );
                      },
                    )
                  ],
                ),
              ),
              child: Center(child: CircularProgressIndicator(),),
            ),
            bottomNavigationBar: Visibility(
              visible: viewModel.loader.value,
              replacement: Padding(
                padding:  EdgeInsets.all(padding_18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: (){
                        NavigatorHelper().add(OrderDetailScreen(isPick: viewModel.dashboardResult?.dashboardDisplayOrder?.orderType=="delivery"?false:true,isDelivery: viewModel.dashboardResult?.dashboardDisplayOrder?.orderType=="delivery"?true:false,isQuickOrder: false,orderId: viewModel.dashboardResult?.dashboardDisplayOrder?.orderId.toString(),orderType: viewModel.dashboardResult?.dashboardDisplayOrder?.orderType??"",));
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
                                            text: viewModel.dashboardResult?.dashboardDisplayOrder?.orderNo??"",
                                            style: Fonts.regularTextStyleBold,
                                          ),
                                          ResponsiveText(
                                            text: viewModel.dashboardResult?.dashboardDisplayOrder?.amount??"0 AED",
                                            style: Fonts.regularTextStyleBold,
                                          ),
                                        ],
                                      ),
                                      ResponsiveText(
                                        text: viewModel.dashboardResult?.dashboardDisplayOrder?.custName??"",
                                        style: Fonts.regularTextStyle.copyWith(
                                            color: Colors.grey
                                        ),
                                      ),
                                    ],
                                  ),),
                                ],
                              ),
                              ResponsiveText(
                                text: viewModel.dashboardResult?.dashboardDisplayOrder?.address??"",
                                style: Fonts.regularTextStyle,
                                maxLines: 2,
                                textAlign: TextAlign.start,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Order type",style: Fonts.regularTextStyle.copyWith(
                                          color: Colors.grey
                                      ),),
                                      Text(viewModel.dashboardResult?.dashboardDisplayOrder?.orderType??"",style: Fonts.regularTextStyleMedium.copyWith(
                                          color: Colors.orange
                                      ),),
                                    ],
                                  ),),
                                  // Expanded(child: Column(
                                  //   crossAxisAlignment: CrossAxisAlignment.end,
                                  //   children: [
                                  //     Text("Status",style: Fonts.regularTextStyle.copyWith(
                                  //         color: Colors.grey
                                  //     ),),
                                  //     Text("Pending",style: Fonts.regularTextStyleMedium.copyWith(
                                  //         color:Colors.blue
                                  //     ),),
                                  //   ],
                                  // ),),
                                ],
                              ),
                              CommonWidget.getFieldSpacer(height: padding_04),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(DateFormat("dd MMM yyyy").format(DateFormat("yyyy-MM-dd").parse(viewModel.dashboardResult?.dashboardDisplayOrder?.date??"2025-07-21")),style: Fonts.regularTextStyle.copyWith(
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
                    ),
                  ],
                ),
              ),
              child: SizedBox(),
            ),
            drawer: Drawer(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: DrawerHeader(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(padding_16),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.appPrimaryColor
                                  ),
                                  child: Icon(Icons.account_circle_outlined,size: padding_40,color: AppColor.appWhiteColor,),
                                ),
                                CommonWidget.getFieldSpacer(height: padding_10),
                                ResponsiveText(
                                  text: PreferenceManager.getString(PrefName.name),
                                  style: Fonts.regularTextStyleMedium.copyWith(
                                    fontSize: fontSize_16
                                  ),
                                ),
                                ResponsiveText(
                                  text: PreferenceManager.getString(PrefName.userName),
                                  style: Fonts.regularTextStyle.copyWith(
                                    fontSize: fontSize_14,
                                    color: Colors.grey
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: (){
                            NavigatorHelper.remove();
                            NavigatorHelper().add(EarningScreen());
                          },
                          contentPadding: EdgeInsets.only(left: padding_10,top: 0,right: 0,bottom: 0),
                          visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                          leading: Icon(Icons.monetization_on_outlined),
                          title: Text("Earning",style: Fonts.regularTextStyle,),
                        ),
                        ListTile(
                          onTap: (){
                            NavigatorHelper.remove();
                            NavigatorHelper().add(NotificationScreen());
                          },
                          contentPadding: EdgeInsets.only(left: padding_10,top: 0,right: 0,bottom: 0),
                          visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                          leading: Icon(Icons.notifications_active_outlined),
                          title: Text("Notification",style: Fonts.regularTextStyle,),
                        ),
                        ListTile(
                          onTap: () {
                            NavigatorHelper.remove();
                            NavigatorHelper().add(TermsAndConditionScreen());
                          },
                          contentPadding: EdgeInsets.only(left: padding_10,top: 0,right: 0,bottom: 0),
                          visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                          leading: Icon(Icons.receipt_outlined),
                          title: Text("Terms & Condition",style: Fonts.regularTextStyle,),
                        ),
                        ListTile(
                          onTap: (){
                            NavigatorHelper.remove();
                            NavigatorHelper().add(PrivacyPolicyScreen());
                          },
                          contentPadding: EdgeInsets.only(left: padding_10,top: 0,right: 0,bottom: 0),
                          visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                          leading: Icon(Icons.privacy_tip_outlined),
                          title: Text("Privacy Policy",style: Fonts.regularTextStyle,),
                        ),
                        ListTile(
                          onTap: (){
                            NavigatorHelper.remove();
                            NavigatorHelper().add(FeedbackScreen());
                          },
                          contentPadding: EdgeInsets.only(left: padding_10,top: 0,right: 0,bottom: 0),
                          visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                          leading: Icon(CupertinoIcons.bubble_left_bubble_right),
                          title: Text("Feedback",style: Fonts.regularTextStyle,),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: (){
                      viewModel.showLogout();
                    },
                    contentPadding: EdgeInsets.only(left: padding_10,top: 0,right: 0,bottom: 0),
                    visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                    leading: Icon(Icons.logout_outlined,color: Colors.red,),
                    title: Text("Logout",style: Fonts.regularTextStyle.copyWith(
                      color: Colors.red
                    ),),
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
