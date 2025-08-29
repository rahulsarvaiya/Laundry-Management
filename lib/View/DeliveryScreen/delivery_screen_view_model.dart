import 'dart:async';
import 'package:driver/Custom/button_view.dart';
import 'package:driver/Helper/navigation_helper.dart';
import 'package:driver/Style/fonts.dart';
import 'package:driver/Utils/Constants.dart';
import 'package:driver/Utils/app_global.dart';
import 'package:driver/View/BottomNavigationBar/bottom_navigation_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../OrderDetail/pick_up_dialog.dart';

class DeliveryScreenViewModel extends ChangeNotifier{

  late BuildContext context;

  final Location location = Location();
  GoogleMapController? mapController;

  LatLng? currentLatLng;
  final LatLng _destinationLatLng = LatLng(19.0760, 72.8777); // Ahmedabad

  Marker? driverMarker;
  late Marker destinationMarker;

  StreamSubscription<LocationData>? locationSubscription;

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  init(BuildContext context){
    this.context = context;

    _startLocationTracking();
    destinationMarker = Marker(
      markerId: MarkerId("destination"),
      position: _destinationLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(title: "Destination"),
    );
    notifyListeners();
  }

  void _startLocationTracking() async {
    // Permission and service check
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) return;
    }

    // Listen to live location
    locationSubscription = location.onLocationChanged.listen((loc) {
      LatLng updatedLatLng = LatLng(loc.latitude!, loc.longitude!);
      _updateDriverMarker(updatedLatLng, loc.heading ?? 0);
    });
  }

  void _updateDriverMarker(LatLng newPosition, double heading) {
    final marker = Marker(
      markerId: MarkerId("driver"),
      position: newPosition,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      rotation: heading,
      anchor: Offset(0.5, 0.5),
      infoWindow: InfoWindow(title: "Driver"),
    );

      currentLatLng = newPosition;
      driverMarker = marker;
      notifyListeners();

    // Optionally move camera to follow driver
    mapController?.animateCamera(
      CameraUpdate.newLatLng(newPosition),
    );
  }

  bool startRide = false;
  rideOnGoing(){
    startRide = true;
    notifyListeners();
    // Future.delayed(Duration(seconds: 15),(){
    //   startRide = false;
    //   notifyListeners();
    // });
  }


  pickUpOrderDialog(bool isDelivery){
    showDialog(
      context: context,
      builder: (context) {
        return PickUpDialog(isDelivery: isDelivery,);
      },
    );
  }

  showPickupNotAvailable(){
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.all(padding_20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(padding_06)
          ),
          child: Padding(
            padding: const EdgeInsets.all(padding_10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Pickup not available",style: Fonts.regularTextStyleBold.copyWith(
                  fontSize: 20
                ),),
                Icon(Icons.hourglass_empty, size: 80, color: Colors.grey),
                SizedBox(height: 20),
                Text("No pickups available right now.",style: Fonts.regularTextStyleMedium.copyWith(
                  fontSize: fontSize_16
                ),),
                SizedBox(height: 20),
                ButtonView(
                  onPressed: (){
                    AppGlobal.bottomNavigationIndex.value = 0;
                    NavigatorHelper.removeAllAndOpen(BottomNavigationBarScreen());
                  },
                  buttonTextName: "Okay",
                  height: 45,
                )
              ],
            ),
          ),
        );
      },
    );
  }

}