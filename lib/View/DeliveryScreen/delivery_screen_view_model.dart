import 'dart:async';
import 'dart:convert';
import 'package:driver/Custom/button_view.dart';
import 'package:driver/Helper/navigation_helper.dart';
import 'package:driver/Style/fonts.dart';
import 'package:driver/Utils/Constants.dart';
import 'package:driver/Utils/app_global.dart';
import 'package:driver/View/BottomNavigationBar/bottom_navigation_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../Model/order_details_response_model.dart';
import '../OrderDetail/pick_up_dialog.dart';
import 'package:http/http.dart' as http;
class DeliveryScreenViewModel extends ChangeNotifier{

  late BuildContext context;

  final Location location = Location();
  GoogleMapController? mapController;

  LatLng? currentLatLng;
  LatLng _destinationLatLng = LatLng(19.0760, 72.8777); // Ahmedabad
  Marker? driverMarker;
  late Marker destinationMarker;

  StreamSubscription<LocationData>? locationSubscription;

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  init(BuildContext context,OrderDetailResult? orderDetails){
    this.context = context;
    getCoordinatesFromAddress(orderDetails?.address??"Mumbai, India");
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

  Future<void> getCoordinatesFromAddress(String address) async {
    try {
      List<geocoding.Location> locations = await geocoding.locationFromAddress(address);

      if (locations.isNotEmpty) {
        geocoding.Location location = locations.first;
        _destinationLatLng = LatLng(location.latitude, location.longitude);
        _createRoute();
        print("Latitude: ${location.latitude}, Longitude: ${location.longitude}");
      } else {
        print("No coordinates found for this address.");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<List<LatLng>> getRoadRoute(LatLng origin, LatLng destination) async {
    const apiKey = "AIzaSyAOVYRIgupAurZup5y1PRh8Ismb1A3lLao";

    final url = Uri.parse(
      "https://maps.googleapis.com/maps/api/directions/json"
          "?origin=${origin.latitude},${origin.longitude}"
          "&destination=${destination.latitude},${destination.longitude}"
          "&mode=driving" // driving | walking | bicycling | transit
          "&key=$apiKey",
    );

    final response = await http.get(url);
    final data = jsonDecode(response.body);

    if (data["status"] == "OK") {
      final points = data["routes"][0]["overview_polyline"]["points"];
      return decodePolyline(points);
    }
    return [];
  }

  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      poly.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return poly;
  }

  void _createRoute() async {
    final routeCoords = await getRoadRoute(currentLatLng!, _destinationLatLng);
    polylines.clear(); // clear old routes
    polylines.add(Polyline(
      polylineId: PolylineId('roadRoute'),
      points: routeCoords,
      color: Colors.blue,
      width: 6,
    ));

    // Move camera to fit route
    if (routeCoords.isNotEmpty) {
      mapController?.animateCamera(
        CameraUpdate.newLatLngBounds(
          _boundsFromLatLngList(routeCoords),
          50,
        ),
      );
    }
  }
  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    double x0 = list.first.latitude, x1 = list.first.latitude;
    double y0 = list.first.longitude, y1 = list.first.longitude;

    for (LatLng latLng in list) {
      if (latLng.latitude > x1) x1 = latLng.latitude;
      if (latLng.latitude < x0) x0 = latLng.latitude;
      if (latLng.longitude > y1) y1 = latLng.longitude;
      if (latLng.longitude < y0) y0 = latLng.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(x0, y0),
      northeast: LatLng(x1, y1),
    );
  }
}