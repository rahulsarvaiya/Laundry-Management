import 'package:flutter/cupertino.dart';

class CommonWidget{

  static Widget getFieldSpacer({double? height, double? width}) {
    return SizedBox(
      height: height ?? 10.0,
      width: width ?? 0.0,
    );
  }

}