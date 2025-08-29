import 'package:driver/Utils/constants.dart';
import 'package:flutter/material.dart';

import 'app_theme.dart';

class Borders {
  static OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(padding_30)),
  );

  static OutlineInputBorder focusBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColor.appPrimaryColor, width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(padding_30)),
  );


  static OutlineInputBorder enableBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(padding_30)),
  );


  static OutlineInputBorder disableBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade600, width: 0),
    borderRadius: const BorderRadius.all(Radius.circular(padding_30)),
  );

  static OutlineInputBorder errorBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(padding_30)),
  );


}
