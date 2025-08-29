import 'dart:io';

import 'package:driver/Custom/custom_text_button.dart';
import 'package:driver/Custom/responsive_text.dart';
import 'package:driver/Helper/navigation_helper.dart';
import 'package:driver/Style/Fonts.dart';
import 'package:driver/Style/app_theme.dart';
import 'package:driver/Utils/common_widget.dart';
import 'package:driver/Utils/constants.dart';
import 'package:driver/View/Order/order_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Model/order_response_model.dart';
import '../OrderDetail/order_detail_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with TickerProviderStateMixin {
  OrderScreenViewModel orderScreenViewModel = OrderScreenViewModel();

  @override
  void initState() {
    super.initState();
    this;
    orderScreenViewModel.init(context,this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => orderScreenViewModel,
      child: Consumer<OrderScreenViewModel>(
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
                text: "Orders",
                style: Fonts.regularTextStyleBold.copyWith(
                  fontSize: fontSize_16
                ),
              ),
              // bottom: PreferredSize(
              //   preferredSize: Size(MediaQuery.of(context).size.width, 45),
              //   child: TabBar(
              //     controller: viewModel.tabController,
              //     indicatorColor: AppColor.appPrimaryColor,
              //     labelStyle: Fonts.regularTextStyleBold.copyWith(
              //       color: AppColor.appWhiteColor,
              //     ),
              //     unselectedLabelStyle: Fonts.regularTextStyleBold.copyWith(
              //       color: Colors.grey
              //     ),
              //     padding: EdgeInsets.zero,
              //     indicatorWeight: 0,
              //     dividerColor: Colors.transparent,
              //     indicatorPadding: EdgeInsets.zero,
              //     labelPadding: EdgeInsets.only(left: padding_08,right: padding_08),
              //     indicator: BoxDecoration(
              //       color: AppColor.appPrimaryColor,
              //       borderRadius: BorderRadius.circular(padding_30),
              //     ),
              //     isScrollable: true,
              //     tabAlignment: TabAlignment.start,
              //     tabs: [
              //       Tab(
              //         child: Container(
              //           padding: EdgeInsets.only(left: padding_10,right: padding_10),
              //           child: Text("UpComing order"),
              //         ),
              //       ),
              //       Tab(
              //         child: Container(
              //           padding: EdgeInsets.only(left: padding_10,right: padding_10),
              //           child: Text("Pick up"),
              //         ),
              //       ),
              //       Tab(
              //         child: Container(
              //           padding: EdgeInsets.only(left: padding_10,right: padding_10),
              //           child: Text("Delivery"),
              //         ),
              //       ),
              //       Tab(
              //         child: Container(
              //           padding: EdgeInsets.only(left: padding_10,right: padding_10),
              //           child: Text("Payment pending"),
              //         ),
              //       ),
              //
              //     ],
              //     overlayColor: WidgetStatePropertyAll(Colors.transparent),
              //   ),
              // ),
              centerTitle: true,
            ),
            body: Visibility(
              visible: viewModel.loader.value,
              replacement: Visibility(
                visible: viewModel.allOrder.isNotEmpty,
                replacement: Center(child: Text("No order founds!"),),
                child: ListView.separated(
                  itemCount: viewModel.allOrder.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(padding_18),
                  separatorBuilder: (context, index) => CommonWidget.getFieldSpacer(height: padding_10),
                  itemBuilder: (context, index) {
                    OrderDataResult order = viewModel.allOrder[index];
                    return InkWell(
                      onTap: (){
                        viewModel.showConfirmDialog();
                        // NavigatorHelper().add(OrderDetailScreen(isPick: true,isDelivery: index.isEven,));
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
                                            text: order.orderNo??"",
                                            style: Fonts.regularTextStyleBold,
                                          ),
                                          ResponsiveText(
                                            text: order.amount??"0 AED",
                                            style: Fonts.regularTextStyleBold,
                                          ),
                                        ],
                                      ),
                                      ResponsiveText(
                                        text: order.custName??"",
                                        style: Fonts.regularTextStyle.copyWith(
                                            color: Colors.grey
                                        ),
                                      ),

                                    ],
                                  ),),
                                ],
                              ),
                              ResponsiveText(
                                text: order.address??"",
                                style: Fonts.regularTextStyle,
                                maxLines: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Order status",style: Fonts.regularTextStyle.copyWith(
                                          color: Colors.grey
                                      ),),
                                      Text(order.orderType??"",style: Fonts.regularTextStyleMedium.copyWith(
                                          color:order.orderType=="delivery"?AppColor.appPrimaryColor:Colors.orange
                                      ),),
                                    ],
                                  ),),
                                  // Expanded(child: Column(
                                  //   crossAxisAlignment: CrossAxisAlignment.end,
                                  //   children: [
                                  //     Text("Status",style: Fonts.regularTextStyle.copyWith(
                                  //         color: Colors.grey
                                  //     ),),
                                  //     Text(index.isEven?"Pending":"Paid",style: Fonts.regularTextStyleMedium.copyWith(
                                  //         color: index.isEven?Colors.blue:Colors.green
                                  //     ),),
                                  //   ],
                                  // ),),
                                ],
                              ),
                              CommonWidget.getFieldSpacer(height: padding_04),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(DateFormat("dd MMM yyyy").format(DateTime.parse(order.date??"2025-08-14")),style: Fonts.regularTextStyle.copyWith(
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
              ),
              child: Center(child: CircularProgressIndicator(),),
            ),
            // body: TabBarView(
            //   controller: viewModel.tabController,
            //   children: [
            //     ListView.separated(
            //       itemCount: 20,
            //       shrinkWrap: true,
            //       padding: EdgeInsets.all(padding_18),
            //       separatorBuilder: (context, index) => CommonWidget.getFieldSpacer(height: padding_10),
            //       itemBuilder: (context, index) {
            //         return InkWell(
            //           onTap: (){
            //             NavigatorHelper().add(OrderDetailScreen(isPick: true,));
            //           },
            //           child: Card(
            //             elevation: 1,
            //             color: AppColor.appWhiteColor,
            //             margin: EdgeInsets.zero,
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(padding_04)
            //             ),
            //             child: Padding(
            //               padding: const EdgeInsets.all(padding_08),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Row(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Container(
            //                         padding: EdgeInsets.all(padding_04),
            //                         decoration: BoxDecoration(
            //                           color: AppColor.appPrimaryColor.withValues(alpha: 0.4),
            //                           shape: BoxShape.circle
            //                         ),
            //                         child: Icon(Icons.person,color: AppColor.appWhiteColor,size: padding_30,),
            //                       ),
            //                       CommonWidget.getFieldSpacer(width: padding_12),
            //                       Expanded(child: Column(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: [
            //                           Row(
            //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                             children: [
            //                               ResponsiveText(
            //                                 text: "#855152635",
            //                                 style: Fonts.regularTextStyleBold,
            //                               ),
            //                               ResponsiveText(
            //                                 text: "\$128",
            //                                 style: Fonts.regularTextStyleBold,
            //                               ),
            //                             ],
            //                           ),
            //                           ResponsiveText(
            //                             text: "Customer Name",
            //                             style: Fonts.regularTextStyle.copyWith(
            //                               color: Colors.grey
            //                             ),
            //                           ),
            //
            //                         ],
            //                       ),),
            //                     ],
            //                   ),
            //                   ResponsiveText(
            //                     text: "123 Main Street New York, NY 10001",
            //                     style: Fonts.regularTextStyle,
            //                     maxLines: 2,
            //                   ),
            //                   Row(
            //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       Expanded(child: Column(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: [
            //                           Text("Status",style: Fonts.regularTextStyle.copyWith(
            //                             color: Colors.grey
            //                           ),),
            //                           Text("Upcoming",style: Fonts.regularTextStyleMedium.copyWith(
            //                               color: Colors.orange
            //                           ),),
            //                         ],
            //                       ),),
            //                       Expanded(child: Column(
            //                         crossAxisAlignment: CrossAxisAlignment.end,
            //                         children: [
            //                           Text("Payment status",style: Fonts.regularTextStyle.copyWith(
            //                               color: Colors.grey
            //                           ),),
            //                           Text("Pending",style: Fonts.regularTextStyleMedium.copyWith(
            //                               color: Colors.blue
            //                           ),),
            //                         ],
            //                       ),),
            //                     ],
            //                   ),
            //                   CommonWidget.getFieldSpacer(height: padding_04),
            //                   Row(
            //                     mainAxisAlignment: MainAxisAlignment.end,
            //                     children: [
            //                       Text("23 Jun 2025,11:50 AM",style: Fonts.regularTextStyle.copyWith(
            //                           color: Colors.grey
            //                       ),
            //                       textAlign: TextAlign.end,
            //                       ),
            //                     ],
            //                   )
            //                 ],
            //               ),
            //             ),
            //           ),
            //         );
            //       },
            //     ),
            //     // ListView.separated(
            //     //   itemCount: 4,
            //     //   shrinkWrap: true,
            //     //   padding: EdgeInsets.all(padding_18),
            //     //   separatorBuilder: (context, index) => CommonWidget.getFieldSpacer(height: padding_10),
            //     //   itemBuilder: (context, index) {
            //     //     return InkWell(
            //     //       onTap: (){
            //     //         NavigatorHelper().add(OrderDetailScreen(isPick: true,));
            //     //       },
            //     //       child: Card(
            //     //         elevation: 1,
            //     //         color: AppColor.appWhiteColor,
            //     //         margin: EdgeInsets.zero,
            //     //         shape: RoundedRectangleBorder(
            //     //             borderRadius: BorderRadius.circular(padding_04)
            //     //         ),
            //     //         child: Padding(
            //     //           padding: const EdgeInsets.all(padding_08),
            //     //           child: Column(
            //     //             crossAxisAlignment: CrossAxisAlignment.start,
            //     //             children: [
            //     //               Row(
            //     //                 crossAxisAlignment: CrossAxisAlignment.start,
            //     //                 children: [
            //     //                   Container(
            //     //                     padding: EdgeInsets.all(padding_04),
            //     //                     decoration: BoxDecoration(
            //     //                         color: AppColor.appPrimaryColor.withValues(alpha: 0.4),
            //     //                         shape: BoxShape.circle
            //     //                     ),
            //     //                     child: Icon(Icons.person,color: AppColor.appWhiteColor,size: padding_30,),
            //     //                   ),
            //     //                   CommonWidget.getFieldSpacer(width: padding_12),
            //     //                   Expanded(child: Column(
            //     //                     crossAxisAlignment: CrossAxisAlignment.start,
            //     //                     children: [
            //     //                       Row(
            //     //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     //                         children: [
            //     //                           ResponsiveText(
            //     //                             text: "#855152635",
            //     //                             style: Fonts.regularTextStyleBold,
            //     //                           ),
            //     //                           ResponsiveText(
            //     //                             text: "\$128",
            //     //                             style: Fonts.regularTextStyleBold,
            //     //                           ),
            //     //                         ],
            //     //                       ),
            //     //                       ResponsiveText(
            //     //                         text: "Customer Name",
            //     //                         style: Fonts.regularTextStyle.copyWith(
            //     //                             color: Colors.grey
            //     //                         ),
            //     //                       ),
            //     //
            //     //                     ],
            //     //                   ),),
            //     //                 ],
            //     //               ),
            //     //               ResponsiveText(
            //     //                 text: "123 Main Street New York, NY 10001",
            //     //                 style: Fonts.regularTextStyle,
            //     //                 maxLines: 2,
            //     //               ),
            //     //               Row(
            //     //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     //                 children: [
            //     //                   Expanded(child: Column(
            //     //                     crossAxisAlignment: CrossAxisAlignment.start,
            //     //                     children: [
            //     //                       Text("Status",style: Fonts.regularTextStyle.copyWith(
            //     //                           color: Colors.grey
            //     //                       ),),
            //     //                       Text(index.isEven?"Ready":"Pick up",style: Fonts.regularTextStyleMedium.copyWith(
            //     //                           color: index.isEven?Colors.lightBlue:AppColor.appPrimaryColor
            //     //                       ),),
            //     //                     ],
            //     //                   ),),
            //     //                   Expanded(child: Column(
            //     //                     crossAxisAlignment: CrossAxisAlignment.end,
            //     //                     children: [
            //     //                       Text("Payment status",style: Fonts.regularTextStyle.copyWith(
            //     //                           color: Colors.grey
            //     //                       ),),
            //     //                       Text("Pending",style: Fonts.regularTextStyleMedium.copyWith(
            //     //                           color: Colors.blue
            //     //                       ),),
            //     //                     ],
            //     //                   ),),
            //     //
            //     //                 ],
            //     //               ),
            //     //               CommonWidget.getFieldSpacer(height: padding_04),
            //     //               Row(
            //     //                 mainAxisAlignment: MainAxisAlignment.end,
            //     //                 children: [
            //     //                   Text("23 Jun 2025,11:50 AM",style: Fonts.regularTextStyle.copyWith(
            //     //                       color: Colors.grey
            //     //                   ),)
            //     //                 ],
            //     //               )
            //     //             ],
            //     //           ),
            //     //         ),
            //     //       ),
            //     //     );
            //     //   },
            //     // ),
            //     // ListView.separated(
            //     //   itemCount: 4,
            //     //   shrinkWrap: true,
            //     //   padding: EdgeInsets.all(padding_18),
            //     //   separatorBuilder: (context, index) => CommonWidget.getFieldSpacer(height: padding_10),
            //     //   itemBuilder: (context, index) {
            //     //     return InkWell(
            //     //       onTap: (){
            //     //         NavigatorHelper().add(OrderDetailScreen(isPick: false,));
            //     //       },
            //     //       child: Card(
            //     //         elevation: 1,
            //     //         color: AppColor.appWhiteColor,
            //     //         margin: EdgeInsets.zero,
            //     //         shape: RoundedRectangleBorder(
            //     //             borderRadius: BorderRadius.circular(padding_04)
            //     //         ),
            //     //         child: Padding(
            //     //           padding: const EdgeInsets.all(padding_08),
            //     //           child: Column(
            //     //             crossAxisAlignment: CrossAxisAlignment.start,
            //     //             children: [
            //     //               Row(
            //     //                 crossAxisAlignment: CrossAxisAlignment.start,
            //     //                 children: [
            //     //                   Container(
            //     //                     padding: EdgeInsets.all(padding_04),
            //     //                     decoration: BoxDecoration(
            //     //                         color: AppColor.appPrimaryColor.withValues(alpha: 0.4),
            //     //                         shape: BoxShape.circle
            //     //                     ),
            //     //                     child: Icon(Icons.person,color: AppColor.appWhiteColor,size: padding_30,),
            //     //                   ),
            //     //                   CommonWidget.getFieldSpacer(width: padding_12),
            //     //                   Expanded(child: Column(
            //     //                     crossAxisAlignment: CrossAxisAlignment.start,
            //     //                     children: [
            //     //                       Row(
            //     //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     //                         children: [
            //     //                           ResponsiveText(
            //     //                             text: "#855152635",
            //     //                             style: Fonts.regularTextStyleBold,
            //     //                           ),
            //     //                           ResponsiveText(
            //     //                             text: "\$128",
            //     //                             style: Fonts.regularTextStyleBold,
            //     //                           ),
            //     //                         ],
            //     //                       ),
            //     //                       ResponsiveText(
            //     //                         text: "Customer Name",
            //     //                         style: Fonts.regularTextStyle.copyWith(
            //     //                             color: Colors.grey
            //     //                         ),
            //     //                       ),
            //     //
            //     //                     ],
            //     //                   ),),
            //     //                 ],
            //     //               ),
            //     //               ResponsiveText(
            //     //                 text: "123 Main Street New York, NY 10001",
            //     //                 style: Fonts.regularTextStyle,
            //     //                 maxLines: 2,
            //     //               ),
            //     //               Row(
            //     //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     //                 children: [
            //     //                   Expanded(child: Column(
            //     //                     crossAxisAlignment: CrossAxisAlignment.start,
            //     //                     children: [
            //     //                       Text("Status",style: Fonts.regularTextStyle.copyWith(
            //     //                           color: Colors.grey
            //     //                       ),),
            //     //                       Text("Delivered",style: Fonts.regularTextStyleMedium.copyWith(
            //     //                           color: Colors.green
            //     //                       ),),
            //     //                     ],
            //     //                   ),),
            //     //
            //     //                   Expanded(child: Column(
            //     //                     crossAxisAlignment: CrossAxisAlignment.end,
            //     //                     children: [
            //     //                       Text("Payment status",style: Fonts.regularTextStyle.copyWith(
            //     //                           color: Colors.grey
            //     //                       ),),
            //     //                       Text(index.isEven?"Completed":"Pending",style: Fonts.regularTextStyleMedium.copyWith(
            //     //                           color: index.isEven?Colors.green:Colors.blue
            //     //                       ),),
            //     //                     ],
            //     //                   ),),
            //     //
            //     //                 ],
            //     //               ),
            //     //               CommonWidget.getFieldSpacer(height: padding_04),
            //     //               Row(
            //     //                 mainAxisAlignment: MainAxisAlignment.end,
            //     //                 children: [
            //     //                   Text("23 Jun 2025,11:50 AM",style: Fonts.regularTextStyle.copyWith(
            //     //                       color: Colors.grey
            //     //                   ),)
            //     //                 ],
            //     //               )
            //     //             ],
            //     //           ),
            //     //         ),
            //     //       ),
            //     //     );
            //     //   },
            //     // ),
            //     // ListView.separated(
            //     //   itemCount: 4,
            //     //   shrinkWrap: true,
            //     //   padding: EdgeInsets.all(padding_18),
            //     //   separatorBuilder: (context, index) => CommonWidget.getFieldSpacer(height: padding_10),
            //     //   itemBuilder: (context, index) {
            //     //     return InkWell(
            //     //       onTap: (){
            //     //         NavigatorHelper().add(OrderDetailScreen(isPick: false,));
            //     //       },
            //     //       child: Card(
            //     //         elevation: 1,
            //     //         color: AppColor.appWhiteColor,
            //     //         margin: EdgeInsets.zero,
            //     //         shape: RoundedRectangleBorder(
            //     //             borderRadius: BorderRadius.circular(padding_04)
            //     //         ),
            //     //         child: Padding(
            //     //           padding: const EdgeInsets.all(padding_08),
            //     //           child: Column(
            //     //             crossAxisAlignment: CrossAxisAlignment.start,
            //     //             children: [
            //     //               Row(
            //     //                 crossAxisAlignment: CrossAxisAlignment.start,
            //     //                 children: [
            //     //                   Container(
            //     //                     padding: EdgeInsets.all(padding_04),
            //     //                     decoration: BoxDecoration(
            //     //                         color: AppColor.appPrimaryColor.withValues(alpha: 0.4),
            //     //                         shape: BoxShape.circle
            //     //                     ),
            //     //                     child: Icon(Icons.person,color: AppColor.appWhiteColor,size: padding_30,),
            //     //                   ),
            //     //                   CommonWidget.getFieldSpacer(width: padding_12),
            //     //                   Expanded(child: Column(
            //     //                     crossAxisAlignment: CrossAxisAlignment.start,
            //     //                     children: [
            //     //                       Row(
            //     //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     //                         children: [
            //     //                           ResponsiveText(
            //     //                             text: "#855152635",
            //     //                             style: Fonts.regularTextStyleBold,
            //     //                           ),
            //     //                           ResponsiveText(
            //     //                             text: "\$128",
            //     //                             style: Fonts.regularTextStyleBold,
            //     //                           ),
            //     //                         ],
            //     //                       ),
            //     //                       ResponsiveText(
            //     //                         text: "Customer Name",
            //     //                         style: Fonts.regularTextStyle.copyWith(
            //     //                             color: Colors.grey
            //     //                         ),
            //     //                       ),
            //     //
            //     //                     ],
            //     //                   ),),
            //     //                 ],
            //     //               ),
            //     //               ResponsiveText(
            //     //                 text: "123 Main Street New York, NY 10001",
            //     //                 style: Fonts.regularTextStyle,
            //     //                 maxLines: 2,
            //     //               ),
            //     //               Row(
            //     //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     //                 children: [
            //     //                   Expanded(child: Column(
            //     //                     crossAxisAlignment: CrossAxisAlignment.start,
            //     //                     children: [
            //     //                       Text("Status",style: Fonts.regularTextStyle.copyWith(
            //     //                           color: Colors.grey
            //     //                       ),),
            //     //                       Text("Delivered",style: Fonts.regularTextStyleMedium.copyWith(
            //     //                           color: Colors.green
            //     //                       ),),
            //     //                     ],
            //     //                   ),),
            //     //                   Expanded(child: Column(
            //     //                     crossAxisAlignment: CrossAxisAlignment.end,
            //     //                     children: [
            //     //                       Text("Payment status",style: Fonts.regularTextStyle.copyWith(
            //     //                           color: Colors.grey
            //     //                       ),),
            //     //                       Text("Pending",style: Fonts.regularTextStyleMedium.copyWith(
            //     //                           color: Colors.blue
            //     //                       ),),
            //     //                     ],
            //     //                   ),),
            //     //                 ],
            //     //               ),
            //     //               CommonWidget.getFieldSpacer(height: padding_04),
            //     //               Row(
            //     //                 mainAxisAlignment: MainAxisAlignment.end,
            //     //                 children: [
            //     //                   Text("23 Jun 2025,11:50 AM",style: Fonts.regularTextStyle.copyWith(
            //     //                       color: Colors.grey
            //     //                   ),),
            //     //                 ],
            //     //               )
            //     //             ],
            //     //           ),
            //     //         ),
            //     //       ),
            //     //     );
            //     //   },
            //     // ),
            //   ],
            // ),
          );
        },
      ),
    );
  }
}

