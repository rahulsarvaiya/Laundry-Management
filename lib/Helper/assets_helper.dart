import 'package:flutter/material.dart';

class AssetsHelper {

  static String getSVGIcon(String name) {
    return "assets/icons/$name";
  }

  static AssetImage getImage(String name) {
    return AssetImage("assets/images/$name");
  }

  static AssetImage getLogo(String name) {
    return AssetImage("assets/logo/$name");
  }

  static Image getAssetImage({required String name, height, width, fit, scale}) {
    return Image.asset(
      'assets/images/$name',
      height: height,
      width: width,
      fit: fit,
      scale: scale,
    );
  }

  static BoxDecoration backGroundDecoration({required String backgroundImage}) {
    return BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/$backgroundImage'),
          fit: BoxFit.fill,
        )
    );
  }

}