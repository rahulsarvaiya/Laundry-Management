import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:driver/Custom/responsive_text.dart';
import 'package:driver/Helper/navigation_helper.dart';
import 'package:driver/Style/app_theme.dart';
import 'package:driver/Style/fonts.dart';
import 'package:driver/Utils/app_global.dart';
import 'package:driver/Utils/common_widget.dart';
import 'package:driver/View/BottomNavigationBar/bottom_navigation_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../Custom/button_view.dart';
import '../../Utils/constants.dart';
import '../PaymentCollect/payment_collect_screen.dart';
class PickUpDialog extends StatefulWidget {
  final bool isDelivery;
  const PickUpDialog({super.key, required this.isDelivery});

  @override
  State<PickUpDialog> createState() => _PickUpDialogState();
}

class _PickUpDialogState extends State<PickUpDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.appWhiteColor,
      elevation: 0,
      insetAnimationCurve: Curves.easeIn,
      insetPadding: EdgeInsets.all(padding_20),
      clipBehavior: Clip.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding_04)
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: padding_20,bottom: 0,left: 0,right: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ResponsiveText(
              text: widget.isDelivery?'Delivery Confirmation':'Pickup Confirmation',
              style: Fonts.regularTextStyleBold.copyWith(
                fontSize: fontSize_18
              ),
            ),
            Divider(),
            CommonWidget.getFieldSpacer(height: padding_08),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: padding_20),
              child: Row(
                children: [
                  Icon(Icons.circle,color: Colors.green,size: 14,),
                  CommonWidget.getFieldSpacer(width: padding_10),
                  Expanded(child: ResponsiveText(
                    text: '2020 Congress Ave,Austin, TX 78701',
                    style: Fonts.regularTextStyle,
                    textAlign: TextAlign.start,
                  ),),
                ],
              ),
            ),
            // CommonWidget.getFieldSpacer(height: padding_08),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: padding_20),
            //   child: Row(
            //     children: [
            //       Icon(Icons.circle,color: Colors.red,size: 14,),
            //       CommonWidget.getFieldSpacer(width: padding_10),
            //       Expanded(child: ResponsiveText(
            //         text: '01 Market Street,San Francisco, CA 94105',
            //         style: Fonts.regularTextStyle,
            //         textAlign: TextAlign.start,
            //       ),),
            //     ],
            //   ),
            // ),
            CommonWidget.getFieldSpacer(height: padding_20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding_20),
              child: InkWell(
                onTap: (){
                  showPicker();
                },
                child: _image!=null?SizedBox(
                    height: 150,
                    child: Image.file(File(_image!.path))):DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    dashPattern: [10, 5],
                    strokeWidth: 2,
                    padding: EdgeInsets.zero,
                    color: Colors.grey.withValues(alpha: 0.5),
                    radius: Radius.circular(padding_04)
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(padding_10),
                    height: 150,
                    child: Center(
                      child: Text(
                        'Photo for package',
                        style: Fonts.regularTextStyleMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            CommonWidget.getFieldSpacer(height: padding_20),
            ElevatedButton(
              onPressed: () {
                if(widget.isDelivery){
                  NavigatorHelper.remove();
                  NavigatorHelper().add(PaymentCollectScreen());
                }
                else{
                  AppGlobal.bottomNavigationIndex.value =0;
                  NavigatorHelper.replace(BottomNavigationBarScreen());
                }
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                maximumSize: Size(MediaQuery.of(context).size.width, 45),
                minimumSize: Size(MediaQuery.of(context).size.width, 45),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero
                ),
              ),
              clipBehavior: Clip.none,
              child: Text("Confirm",style: Fonts.regularTextStyleMedium.copyWith(
                color: AppColor.appWhiteColor
              ),),
            )


          ],
        ),
      ),
    );
  }

  showPicker(){
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 0,
          backgroundColor: AppColor.appWhiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(padding_04)
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: padding_60),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: (){
                  _pickImage(ImageSource.gallery);
                },
                contentPadding: EdgeInsets.only(left: padding_10),
                visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                leading: Icon(Icons.photo_camera_back_outlined,size: padding_20,),
                title: Text("Gallery",style: Fonts.regularTextStyleMedium,),
              ),
              Divider(),
              ListTile(
                onTap: (){
                  _pickImage(ImageSource.camera);
                },
                contentPadding: EdgeInsets.only(left: padding_10),
                visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                leading: Icon(Icons.camera_alt_outlined,size: padding_20,),
                title: Text("Camera",style: Fonts.regularTextStyleMedium,),
              ),
            ],
          ),
        );
      },
    );
  }

  File? _image;

  // Main image picking function
  Future<void> _pickImage(ImageSource source) async {
    final hasPermission = await _requestPermissions(source);

    if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Permission not granted")),
      );
      return;
    }

    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        NavigatorHelper.remove();
      });
    }
  }

  // Request permissions based on platform/version
  Future<bool> _requestPermissions(ImageSource source) async {
    if (Platform.isAndroid) {
      final version = await _getAndroidVersion();

      if (source == ImageSource.camera) {
        final status = await Permission.camera.request();
        return status.isGranted;
      } else {
        if (version >= 33) {
          final photos = await Permission.photos.request();
          return photos.isGranted;
        } else {
          final storage = await Permission.manageExternalStorage.request();
          if (storage.isGranted) return true;
          if (storage.isPermanentlyDenied) {
            openAppSettings();
          }
          return false;
        }
      }
    } else if (Platform.isIOS) {
      if (source == ImageSource.camera) {
        final camera = await Permission.camera.request();
        return camera.isGranted;
      } else {
        final photos = await Permission.photos.request();
        return photos.isGranted;
      }
    }
    return false;
  }

  // Get Android major version
  Future<int> _getAndroidVersion() async {
    final version = Platform.operatingSystemVersion;
    final match = RegExp(r'Android (\d+)').firstMatch(version);
    return match != null ? int.tryParse(match.group(1) ?? '') ?? 0 : 0;
  }

  showDeliveryDialog(){
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(padding_04)
          ),
          insetPadding: EdgeInsets.all(padding_20),
          child: Padding(
            padding: const EdgeInsets.all(padding_10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ResponsiveText(
                    text: "Confirm Delivery",
                    style: Fonts.regularTextStyleBold.copyWith(
                        fontSize: fontSize_20
                    ),
                  ),
                ),
                // RichText(
                //   textAlign: TextAlign.start,
                //   text: TextSpan(
                //       text: "Order ID : ",
                //       style: Fonts.regularTextStyle.copyWith(
                //           color: Colors.grey
                //       ),
                //       children: [
                //         TextSpan(
                //             text: "#48523618",
                //             style: Fonts.regularTextStyleMedium
                //         )
                //       ]
                //   ),
                // ),
                // CommonWidget.getFieldSpacer(height: padding_04),
                // RichText(
                //   textAlign: TextAlign.start,
                //   text: TextSpan(
                //       text: "Customer: ",
                //       style: Fonts.regularTextStyle.copyWith(
                //           color: Colors.grey
                //       ),
                //       children: [
                //         TextSpan(
                //             text: "John Doe",
                //             style: Fonts.regularTextStyleMedium
                //         )
                //       ]
                //   ),
                // ),
                // CommonWidget.getFieldSpacer(height: padding_04),
                // RichText(
                //   textAlign: TextAlign.start,
                //   text: TextSpan(
                //       text: "Delivery Address: ",
                //       style: Fonts.regularTextStyle.copyWith(
                //           color: Colors.grey
                //       ),
                //       children: [
                //         TextSpan(
                //             text: "123 Main Street, New York, NY",
                //             style: Fonts.regularTextStyleMedium
                //         )
                //       ]
                //   ),
                // ),
                // CommonWidget.getFieldSpacer(height: padding_04),
                // RichText(
                //   textAlign: TextAlign.start,
                //   text: TextSpan(
                //       text: "Payment: ",
                //       style: Fonts.regularTextStyle.copyWith(
                //           color: Colors.grey
                //       ),
                //       children: [
                //         TextSpan(
                //             text: "AED 500 (Paid Online)",
                //             style: Fonts.regularTextStyleMedium
                //         )
                //       ]
                //   ),
                // ),
                // CommonWidget.getFieldSpacer(height: padding_20),
                Row(
                  children: [
                    Expanded(
                      child: ButtonView(
                        onPressed: (){
                          NavigatorHelper.remove();
                        },
                        buttonTextName: "Cancel",
                        height: 40,
                        borderColor: Colors.grey,
                        color: Colors.grey,
                      ),
                    ),
                    CommonWidget.getFieldSpacer(width: padding_20),
                    Expanded(
                      child: ButtonView(
                        onPressed: (){
                          NavigatorHelper().add(PaymentCollectScreen());
                          // AppGlobal.bottomNavigationIndex.value =0;
                          // NavigatorHelper.removeAllAndOpen(BottomNavigationBarScreen());
                        },
                        buttonTextName: "Collect Payment",
                        height: 40,
                      ),
                    ),

                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

}
