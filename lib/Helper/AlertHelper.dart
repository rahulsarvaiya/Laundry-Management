import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Style/Fonts.dart';
import '../Style/app_theme.dart';
import 'SnackbarHelper/CustomSnackbar.dart';
import 'SnackbarHelper/TopSnackBar.dart';

class AlertHelper {

  static showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static showAppSnackBar(BuildContext context, {String message = '', bool isError = false,double? height,int? maxLine}) {
    if (!context.mounted) return;
    if (message.isNotEmpty) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: message,
          textAlign: TextAlign.start,
          backgroundColor: isError ? Colors.red : AppColor.appPrimaryColor.withValues(alpha: 0.9),
          textStyle: Fonts.regularTextStyleLight.copyWith(fontSize: 14, color: AppColor.appWhiteColor),
          height: height,
          maxLines: maxLine??3,
        ),
      );
    }
  }
}
