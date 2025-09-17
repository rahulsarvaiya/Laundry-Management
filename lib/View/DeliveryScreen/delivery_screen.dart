import 'package:driver/Custom/button_view.dart';
import 'package:driver/Custom/responsive_text.dart';
import 'package:driver/Style/Fonts.dart';
import 'package:driver/Style/app_theme.dart';
import 'package:driver/Utils/Constants.dart';
import 'package:driver/Utils/common_widget.dart';
import 'package:driver/View/DeliveryScreen/delivery_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../Model/order_details_response_model.dart';
class DeliveryScreen extends StatefulWidget {
  final bool isDelivery;
  final OrderDetailResult? orderDetail;
  const DeliveryScreen({super.key, required this.isDelivery, this.orderDetail});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {

  DeliveryScreenViewModel deliveryScreenViewModel = DeliveryScreenViewModel();

  @override
  void initState() {
    super.initState();
    deliveryScreenViewModel.init(context,widget.orderDetail);
  }

  @override
  void dispose() {
    deliveryScreenViewModel.locationSubscription?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    print(widget.orderDetail?.address??"");
    return ChangeNotifierProvider(
      create: (context) => deliveryScreenViewModel,
      child: Consumer<DeliveryScreenViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(title: Text("Route")),
            body:  viewModel.currentLatLng == null
                ? Center(child: CircularProgressIndicator())
                : Text("Google map")/*GoogleMap(
              initialCameraPosition: CameraPosition(
                target: viewModel.currentLatLng!,
                zoom: 16,
              ),
              markers: {
                if (viewModel.driverMarker != null) viewModel.driverMarker!,
                viewModel.destinationMarker,
              },
              polylines: viewModel.polylines,
              onMapCreated: (controller) => viewModel.mapController = controller,
            )*/,

            bottomNavigationBar: Container(
              color: AppColor.appWhiteColor,
              padding: EdgeInsets.only(left: padding_16,right: padding_16,top: padding_10),
              margin: EdgeInsets.only(bottom: padding_20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResponsiveText(
                    text: widget.isDelivery?"Delivery address":"Pickup address",
                    style: Fonts.regularTextStyleBold.copyWith(
                      fontSize: fontSize_16
                    ),
                  ),
                  ResponsiveText(
                    text: widget.orderDetail?.address??"",
                    style: Fonts.regularTextStyle.copyWith(
                      color: Colors.grey
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ),
                  CommonWidget.getFieldSpacer(height: padding_20),
                  ButtonView(
                    // buttonTextName: viewModel.startRide?"Delivered":"Start",
                    buttonTextName:widget.isDelivery?"Delivery": "Pickup",
                    onPressed: (){
                      viewModel.pickUpOrderDialog(widget.isDelivery,widget.orderDetail!);

                        // viewModel.showDeliveryDialog();
                      // if(viewModel.startRide){
                      //   viewModel.showDeliveryDialog();
                      // }
                      // else{
                      //   viewModel.rideOnGoing();
                      // }
                    },
                    borderColor: Colors.green,
                    color:Colors.green,
                  ),
                  widget.isDelivery?SizedBox():CommonWidget.getFieldSpacer(height: padding_12),
                  widget.isDelivery?SizedBox():ButtonView(
                    buttonTextName: "Pickup not available",
                    onPressed: (){
                      viewModel.showPickupNotAvailable();
                    },
                    color: Colors.red,
                    borderColor: Colors.red,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
