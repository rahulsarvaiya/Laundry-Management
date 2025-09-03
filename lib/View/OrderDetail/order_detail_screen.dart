import 'dart:io';

import 'package:driver/Custom/button_view.dart';
import 'package:driver/Custom/responsive_text.dart';
import 'package:driver/Helper/navigation_helper.dart';
import 'package:driver/Style/Fonts.dart';
import 'package:driver/Style/app_theme.dart';
import 'package:driver/Utils/app_global.dart';
import 'package:driver/Utils/common_widget.dart';
import 'package:driver/View/DeliveryScreen/delivery_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Custom/custom_text_button.dart';
import '../../Model/order_details_response_model.dart';
import '../../Utils/Constants.dart';
import '../PaymentCollect/payment_collect_screen.dart';
import 'order_detail_screen_view_model.dart';

class OrderDetailScreen extends StatefulWidget {
  final bool isPick;
  final bool isDelivery;
  final String? orderId;
  final String? orderType;
  final bool? isQuickOrder;

  const OrderDetailScreen({super.key, required this.isPick, required this.isDelivery,this.orderType,this.orderId,this.isQuickOrder});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  OrderDetailScreenViewModel orderDetailScreenViewModel =
      OrderDetailScreenViewModel();

  @override
  void initState() {
    super.initState();
    orderDetailScreenViewModel.init(context,widget.orderId??"",widget.orderType??"",widget.isQuickOrder??false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => orderDetailScreenViewModel,
      child: Consumer<OrderDetailScreenViewModel>(
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
                text: "Order Details",
                style: Fonts.regularTextStyleBold.copyWith(
                  fontSize: fontSize_16,
                  color: AppColor.appWhiteColor,
                ),
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
            ),
            body: Visibility(
              visible: viewModel.loader.value,
              replacement: SingleChildScrollView(
                padding: EdgeInsets.only(top: padding_20,bottom: AppGlobal.hasBottomNotch(context)?padding_40:padding_20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: padding_20,
                        right: padding_20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ResponsiveText(
                            text: "Ready to ${widget.orderType}",
                            style: Fonts.regularTextStyleBold,
                          ),
                          Container(
                            padding: EdgeInsets.all(padding_02),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.call, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: padding_20,
                        right: padding_20,
                        top: widget.isPick ? padding_04 : 0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1), // shadow color
                            spreadRadius: 2, // how wide the shadow spreads
                            blurRadius: 6, // how soft the shadow is
                            offset: Offset(0, 3), // position of the shadow (X, Y)
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(padding_10),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ResponsiveText(
                            text: 'Order number',
                            style: Fonts.regularTextStyle.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          ResponsiveText(
                            text: viewModel.orderDetail?.orderNo??"",
                            style: Fonts.regularTextStyleBold,
                          ),

                          CommonWidget.getFieldSpacer(height: padding_04),
                          ResponsiveText(
                            text: 'Customer name',
                            style: Fonts.regularTextStyle.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          ResponsiveText(
                            text: viewModel.orderDetail?.custName??"",
                            style: Fonts.regularTextStyleBold,
                          ),

                          CommonWidget.getFieldSpacer(height: padding_04),
                          ResponsiveText(
                            text: 'Time',
                            style: Fonts.regularTextStyle.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          ResponsiveText(
                            text: DateFormat("dd MMM yyyy, hh:mm a").format(DateFormat("yyyy-MM-dd HH:mm:ss").parse(viewModel.orderDetail?.time??"2025-07-21 14:26:16")),
                            style: Fonts.regularTextStyleBold,
                          ),

                          //TODO:Required more check this
                          // Visibility(
                          //   visible: !widget.isPick,
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       CommonWidget.getFieldSpacer(height: padding_04),
                          //       ResponsiveText(
                          //         text: 'Delivery time',
                          //         style: Fonts.regularTextStyle.copyWith(
                          //           color: Colors.grey,
                          //         ),
                          //       ),
                          //       ResponsiveText(
                          //         text: '23 Jun 2025,11:50 AM',
                          //         style: Fonts.regularTextStyleBold,
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          CommonWidget.getFieldSpacer(height: padding_04),
                          ResponsiveText(
                            text: 'Address',
                            style: Fonts.regularTextStyle.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          ResponsiveText(
                            text: viewModel.orderDetail?.address??"",
                            style: Fonts.regularTextStyleBold,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                          ),
                          //TODO:i ask to sir after check both address show required or not
                          // CommonWidget.getFieldSpacer(height: padding_04),
                          // ResponsiveText(
                          //   text: 'Delivery address',
                          //   style: Fonts.regularTextStyle.copyWith(
                          //     color: Colors.grey,
                          //   ),
                          // ),
                          // ResponsiveText(
                          //   text: '01 Market Street,San Francisco, CA 94105',
                          //   style: Fonts.regularTextStyleBold,
                          //   maxLines: 2,
                          // ),

                          CommonWidget.getFieldSpacer(height: padding_04),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         ResponsiveText(
                          //           text: 'Payment mode',
                          //           style: Fonts.regularTextStyle.copyWith(
                          //             color: Colors.grey,
                          //           ),
                          //         ),
                          //         ResponsiveText(
                          //           text: 'Cash',
                          //           style: Fonts.regularTextStyleBold,
                          //           maxLines: 2,
                          //         ),
                          //       ],
                          //     ),
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.end,
                          //       children: [
                          //         ResponsiveText(
                          //           text: 'Payment status',
                          //           style: Fonts.regularTextStyle.copyWith(
                          //             color: Colors.grey,
                          //           ),
                          //         ),
                          //         ResponsiveText(
                          //           text: 'Pending',
                          //           style: Fonts.regularTextStyleBold,
                          //           maxLines: 2,
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                        left: padding_20,
                        right: padding_20,
                        top: padding_10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ResponsiveText(
                            text: "Service items",
                            style: Fonts.regularTextStyleBold,
                          ),
                          // SizedBox(
                          //   height: 35,
                          //   child: ElevatedButton(
                          //     onPressed: () {},
                          //     style: ElevatedButton.styleFrom(
                          //       backgroundColor: AppColor.appPrimaryColor,
                          //       elevation: 0,
                          //     ),
                          //     child: Text(
                          //       "Edit order",
                          //       style: Fonts.regularTextStyleMedium.copyWith(
                          //         color: AppColor.appWhiteColor,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(
                        left: padding_20,
                        right: padding_20,
                        top: padding_10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1), // shadow color
                            spreadRadius: 2, // how wide the shadow spreads
                            blurRadius: 6, // how soft the shadow is
                            offset: Offset(0, 3), // position of the shadow (X, Y)
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(left: padding_10,right: padding_10,bottom: padding_10),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          (viewModel.orderDetail?.lineItems?.isNotEmpty??false)?ListView.builder(
                            shrinkWrap: true,
                            itemCount: (viewModel.orderDetail?.lineItems?.length??0),
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              LineItems item = viewModel.orderDetail!.lineItems![index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                              title: Text(item.itemName??"",style: Fonts.regularTextStyleMedium,),
                              subtitle: Text("${item.qty??0}",style: Fonts.regularTextStyle.copyWith(
                                  color: Colors.grey
                              ),),
                              // trailing: Text("AED 2",style: Fonts.regularTextStyleBold,),
                            );
                            },
                          ):SizedBox(
                              height: 50,
                              child: Center(child: Text("This is pickup order"),)),
                          // ListTile(
                          //   contentPadding: EdgeInsets.zero,
                          //   visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                          //   title: Text("Shirt",style: Fonts.regularTextStyleMedium,),
                          //   subtitle: Text("1 X 5 Wash and Fold",style: Fonts.regularTextStyle.copyWith(
                          //       color: Colors.grey
                          //   ),),
                          //   trailing: Text("AED 5",style: Fonts.regularTextStyleBold,),
                          // ),
                          // // Theme(
                          // //   data: Theme.of(context).copyWith(
                          // //     dividerColor: Colors.transparent,
                          // //   ),
                          // //   child: ExpansionTile(
                          // //     title: SizedBox(),
                          // //     // title: Text("Wash and Fold",style: Fonts.regularTextStyleBold,),
                          // //     tilePadding: EdgeInsets.zero,
                          // //     initiallyExpanded: true,
                          // //     childrenPadding: EdgeInsets.zero,
                          // //     expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          // //     expandedAlignment: Alignment.topLeft,
                          // //     visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                          // //     children: <Widget>[
                          // //       ListTile(
                          // //         contentPadding: EdgeInsets.zero,
                          // //         visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                          // //         title: Text("Shirt",style: Fonts.regularTextStyleMedium,),
                          // //         subtitle: Text("1 X 2 AED"+" Wash and Fold",style: Fonts.regularTextStyle.copyWith(
                          // //           color: Colors.grey
                          // //         ),),
                          // //         trailing: Text("AED 2",style: Fonts.regularTextStyleBold,),
                          // //       ),
                          // //       ListTile(
                          // //         contentPadding: EdgeInsets.zero,
                          // //         visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                          // //         title: Text("Shirt",style: Fonts.regularTextStyleMedium,),
                          // //         subtitle: Text("1 X AED 5/per pieces",style: Fonts.regularTextStyle.copyWith(
                          // //             color: Colors.grey
                          // //         ),),
                          // //         trailing: Text("AED 5",style: Fonts.regularTextStyleBold,),
                          // //       ),
                          // //     ],
                          // //   ),
                          // // ),
                          // // Theme(
                          // //   data: Theme.of(context).copyWith(
                          // //     dividerColor: Colors.transparent,
                          // //   ),
                          // //   child: ExpansionTile(
                          // //     title: Text("Wash and Iron",style: Fonts.regularTextStyleBold,),
                          // //     tilePadding: EdgeInsets.zero,
                          // //     initiallyExpanded: true,
                          // //     childrenPadding: EdgeInsets.zero,
                          // //     expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          // //     expandedAlignment: Alignment.topLeft,
                          // //     visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                          // //     children: <Widget>[
                          // //       ListTile(
                          // //         contentPadding: EdgeInsets.zero,
                          // //         visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                          // //         title: Text("Shirt",style: Fonts.regularTextStyleMedium,),
                          // //         subtitle: Text("1 X AED 2/per pieces",style: Fonts.regularTextStyle.copyWith(
                          // //           color: Colors.grey
                          // //         ),),
                          // //         trailing: Text("AED 2",style: Fonts.regularTextStyleBold,),
                          // //       ),
                          // //     ],
                          // //   ),
                          // // ),
                          // ListTile(
                          //   contentPadding: EdgeInsets.zero,
                          //   visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                          //   title: Text("Shirt",style: Fonts.regularTextStyleMedium,),
                          //   subtitle: Text("1 X 2 Wash and Iron",style: Fonts.regularTextStyle.copyWith(
                          //       color: Colors.grey
                          //   ),),
                          //   trailing: Text("AED 2",style: Fonts.regularTextStyleBold,),
                          // ),
                          // // Theme(
                          // //   data: Theme.of(context).copyWith(
                          // //     dividerColor: Colors.transparent,
                          // //   ),
                          // //   child: ExpansionTile(
                          // //     title: Text("Dry Wash",style: Fonts.regularTextStyleBold,),
                          // //     tilePadding: EdgeInsets.zero,
                          // //     initiallyExpanded: true,
                          // //     childrenPadding: EdgeInsets.zero,
                          // //     expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          // //     expandedAlignment: Alignment.topLeft,
                          // //     visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                          // //     children: <Widget>[
                          // //       ListTile(
                          // //         contentPadding: EdgeInsets.zero,
                          // //         visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                          // //         title: Text("Shirt",style: Fonts.regularTextStyleMedium,),
                          // //         subtitle: Text("1 X AED 2/per pieces",style: Fonts.regularTextStyle.copyWith(
                          // //           color: Colors.grey
                          // //         ),),
                          // //         trailing: Text("AED 2",style: Fonts.regularTextStyleBold,),
                          // //       ),
                          // //       ListTile(
                          // //         contentPadding: EdgeInsets.zero,
                          // //         visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                          // //         title: Text("Shirt",style: Fonts.regularTextStyleMedium,),
                          // //         subtitle: Text("1 X AED 5/per pieces",style: Fonts.regularTextStyle.copyWith(
                          // //           color: Colors.grey
                          // //         ),),
                          // //         trailing: Text("AED 5",style: Fonts.regularTextStyleBold,),
                          // //       ),
                          // //     ],
                          // //   ),
                          // // ),
                          // ListTile(
                          //   contentPadding: EdgeInsets.zero,
                          //   visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                          //   title: Text("Shirt",style: Fonts.regularTextStyleMedium,),
                          //   subtitle: Text("1 X 2 Dry Wash",style: Fonts.regularTextStyle.copyWith(
                          //       color: Colors.grey
                          //   ),),
                          //   trailing: Text("AED 2",style: Fonts.regularTextStyleBold,),
                          // ),
                          // ListTile(
                          //   contentPadding: EdgeInsets.zero,
                          //   visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                          //   title: Text("Shirt",style: Fonts.regularTextStyleMedium,),
                          //   subtitle: Text("1 X 5 Dry Wash",style: Fonts.regularTextStyle.copyWith(
                          //       color: Colors.grey
                          //   ),),
                          //   trailing: Text("AED 5",style: Fonts.regularTextStyleBold,),
                          // ),
                          widget.isDelivery?Divider():SizedBox(),
                          widget.isDelivery?ListTile(
                            contentPadding: EdgeInsets.zero,
                            visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                            title: Text("SubTotal",style: Fonts.regularTextStyleMedium,),
                            trailing: Text(viewModel.orderDetail?.orderTotal??"",style: Fonts.regularTextStyleBold,),
                          ):SizedBox(),
                          // widget.isDelivery?ListTile(
                          //   contentPadding: EdgeInsets.zero,
                          //   visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                          //   title: Text("GST(18%)",style: Fonts.regularTextStyleMedium,),
                          //   trailing: Text("AED 5",style: Fonts.regularTextStyleBold,),
                          // ):SizedBox(),
                          widget.isDelivery?Divider():SizedBox(),
                          widget.isDelivery?ListTile(
                            contentPadding: EdgeInsets.zero,
                            visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                            title: Text("Total",style: Fonts.regularTextStyleBold,),
                            trailing: Text(viewModel.orderDetail?.orderTotal??"",style: Fonts.regularTextStyleBold,),
                          ):SizedBox(),
                        ],
                      ),
                    ),

                    Visibility(
                      // visible: widget.isPick,
                      // replacement: Center(
                      //   child: Padding(
                      //     padding: EdgeInsets.only(left: padding_20,right: padding_20,bottom: AppGlobal.hasBottomNotch(context)?padding_20:padding_20,top: padding_40),
                      //     child: ButtonView(
                      //         buttonTextName: "Collect Payment",
                      //         onPressed: (){
                      //           NavigatorHelper().add(PaymentCollectScreen());
                      //         }
                      //     ),
                      //   ),
                      // ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: padding_20,right: padding_20,bottom: AppGlobal.hasBottomNotch(context)?padding_20:padding_20,top: padding_40),
                          child: Row(
                            children: [
                              Expanded(
                                child: ButtonView(
                                  buttonTextName: widget.isDelivery?"Delivery":"PICKUP",
                                  onPressed: (){
                                    NavigatorHelper().add(DeliveryScreen(isDelivery: widget.isDelivery,orderDetail: viewModel.orderDetail,));
                                  },
                                ),
                              ),
                              // CommonWidget.getFieldSpacer(width: padding_20),
                              // Expanded(
                              //   child: ButtonView(
                              //     buttonTextName: "Show Location",
                              //     onPressed: (){
                              //       NavigatorHelper().add(DeliveryScreen());
                              //     },
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              child: Center(child: CircularProgressIndicator(),),
            ),
          );
        },
      ),
    );
  }
}
