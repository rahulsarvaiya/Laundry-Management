import 'package:flutter/material.dart';

class AppTheme {
  static Color lightBG = const Color(0xFFFFFFFF);
  static String appSemiBoldFont = "AppSemiBold";

  static Map<int, Color> myColor = {
    50: const Color.fromRGBO(17, 112, 217, .1),
    100: const Color.fromRGBO(17, 112, 217, .2),
    200: const Color.fromRGBO(17, 112, 217, .3),
    300: const Color.fromRGBO(17, 112, 217, .4),
    400: const Color.fromRGBO(17, 112, 217, .5),
    500: const Color.fromRGBO(17, 112, 217, .6),
    600: const Color.fromRGBO(17, 112, 217, .7),
    700: const Color.fromRGBO(17, 112, 217, .8),
    800: const Color.fromRGBO(17, 112, 217, .9),
    900: const Color.fromRGBO(17, 112, 217, 1),
  };

  static MaterialColor colorCustom = MaterialColor(0xFF010432, myColor);

  static ThemeData lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColor.appPrimaryColor.withOpacity(.5),
      cursorColor: AppColor.appPrimaryColor.withOpacity(.6),
      selectionHandleColor: AppColor.appPrimaryColor.withOpacity(1),
    ),
    fontFamily: "AppRegular",
    primaryColor: colorCustom,
    focusColor: colorCustom,
    scaffoldBackgroundColor: lightBG,
    bottomSheetTheme:
    BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
    appBarTheme: const AppBarTheme(
      elevation: 0,
    ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: colorCustom)
        .copyWith(secondary: colorCustom)
        .copyWith(background: Colors.white),
  );
}

class AppColor {
  static Color appPrimaryColor = const Color(0xFF2D3091);
  static Color appWhiteColor = const Color(0xFFFFFFFF);
  static Color appBlackColor = const Color(0xFF000000);
}
