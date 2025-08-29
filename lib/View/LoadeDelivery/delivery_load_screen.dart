import 'dart:io';

import 'package:driver/Custom/button_view.dart';
import 'package:driver/Helper/AlertHelper.dart';
import 'package:driver/Utils/app_global.dart';
import 'package:driver/Utils/common_widget.dart';
import 'package:driver/View/LoadeDelivery/delivery_load_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Custom/custom_text_button.dart';
import '../../Custom/responsive_text.dart';
import '../../Helper/navigation_helper.dart';
import '../../Model/load_delivery_response.dart';
import '../../Style/Fonts.dart';
import '../../Style/app_theme.dart';
import '../../Utils/Constants.dart';
class DeliveryLoadScreen extends StatefulWidget {
  const DeliveryLoadScreen({super.key});

  @override
  State<DeliveryLoadScreen> createState() => _DeliveryLoadScreenState();
}

class _DeliveryLoadScreenState extends State<DeliveryLoadScreen> {

  DeliveryLoadScreenViewModel deliveryLoadScreenViewModel = DeliveryLoadScreenViewModel();

  @override
  void initState() {
    super.initState();
    deliveryLoadScreenViewModel.init(context);
  }

  @override
  Widget build(BuildContext context) {
   return ChangeNotifierProvider(
     create: (context) => deliveryLoadScreenViewModel,
     child: Consumer<DeliveryLoadScreenViewModel>(
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
             text: "Delivery",
             style: Fonts.regularTextStyleBold.copyWith(
               fontSize: fontSize_16,
               color: AppColor.appWhiteColor,
             ),
             textAlign: TextAlign.center,
           ),
           centerTitle: true,
         ),
           body: viewModel.isRefreshing
               ? Center(
             child: CircularProgressIndicator(),
           )
               : viewModel.allDelivery.isEmpty?Center(child: Text("No Data found"),):ListView.separated(
             itemCount: viewModel.allDelivery.length,
             shrinkWrap: true,
             separatorBuilder: (context, index) => CommonWidget.getFieldSpacer(height: padding_10),
             padding: EdgeInsets.all(padding_20),
             itemBuilder: (context, index) {
               LoadResult item = viewModel.allDelivery[index];
               return InkWell(
                 onTap: (){
                   viewModel.changeLoad(index);
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
                                     Expanded(
                                       child: ResponsiveText(
                                         text: item.laundryOrderNo??"",
                                         style: Fonts.regularTextStyleBold,
                                         textAlign: TextAlign.start,
                                       ),
                                     ),
                                     ResponsiveText(
                                       text: item.amount??"0 AED",
                                       style: Fonts.regularTextStyleBold,
                                     ),
                                     Checkbox(
                                       value: item.isSelected,
                                       onChanged: (value) {
                                         viewModel.changeLoad(index);
                                       },
                                     ),
                                   ],
                                 ),
                                 ResponsiveText(
                                   text: item.custName??"",
                                   textAlign: TextAlign.start,
                                   style: Fonts.regularTextStyle.copyWith(
                                       color: Colors.grey
                                   ),
                                 ),
                               ],
                             ),),
                           ],
                         ),
                         ResponsiveText(
                           text: item.address??"",
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
                                 Text(item.orderType??"",style: Fonts.regularTextStyleMedium.copyWith(
                                     color:Colors.orange
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
                             Text(DateFormat("dd MMM yyyy").format(DateTime.parse(item.date??"2025-08-14")),style: Fonts.regularTextStyle.copyWith(
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
               // return CheckboxListTile(
               //   value: viewModel.allLoad[index].isSelected,
               //   onChanged: (value) {
               //     viewModel.changeLoad(index);
               //   },
               //   contentPadding: EdgeInsets.zero,
               //   visualDensity: VisualDensity(vertical: -4,horizontal: -4),
               //   secondary: Column(
               //     children: [
               //       Text("Qty.",style: Fonts.regularTextStyle.copyWith(
               //         color: Colors.grey,
               //         fontSize: 10,
               //       ),),
               //       CommonWidget.getFieldSpacer(height: padding_02),
               //       Text("${viewModel.allLoad[index].quantity}",style: Fonts.regularTextStyleMedium,),
               //     ],
               //   ),
               //   title: Text(viewModel.allLoad[index].title,style: Fonts.regularTextStyleMedium,),
               //   subtitle: Column(
               //     crossAxisAlignment: CrossAxisAlignment.start,
               //     children: [
               //       Text(viewModel.allLoad[index].customerName,style: Fonts.regularTextStyle.copyWith(
               //         fontSize: 12
               //       ),),
               //       Text(viewModel.allLoad[index].address,style: Fonts.regularTextStyle.copyWith(
               //         fontSize: 10,
               //         color: Colors.grey
               //       ),)
               //     ],
               //   ),
               //   controlAffinity: ListTileControlAffinity.leading,
               // );
             },
           ),
           bottomNavigationBar: Visibility(
             visible: !viewModel.isRefreshing,
             child: Padding(
               padding: EdgeInsets.only(left: padding_20,right: padding_20,bottom: AppGlobal.hasBottomNotch(context)?padding_40:padding_20),
               child: Row(
                 children: [
                   Expanded(
                     child: ButtonView(
                       onPressed: (){
                         viewModel.refreshUI();
                       },
                       buttonTextName: 'Refresh',
                       height: 40,
                     ),
                   ),
                   CommonWidget.getFieldSpacer(width: padding_20),
                   Expanded(
                     child: ButtonView(
                       onPressed: (){
                         if (viewModel.allDelivery.any((load) => load.isSelected == false)) {
                           AlertHelper.showAppSnackBar(context,message: "Please select all load");
                         } else {
                           NavigatorHelper.remove(value: true);
                         }
                       },
                       buttonTextName: 'Done',
                       height: 40,
                       color: viewModel.allDelivery.any((load) => load.isSelected == false)?AppColor.appPrimaryColor.withValues(alpha: 0.5):AppColor.appPrimaryColor,
                       borderColor: viewModel.allDelivery.any((load) => load.isSelected == false)?AppColor.appPrimaryColor.withValues(alpha: 0.5):AppColor.appPrimaryColor,
                     ),
                   ),
                 ],
               ),
             ),
           ),
         );
       },
     ),
   );
  }
}
