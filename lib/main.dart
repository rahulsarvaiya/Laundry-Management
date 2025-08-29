import 'package:driver/Style/app_theme.dart';
import 'package:driver/View/BottomNavigationBar/bottom_navigation_bar_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Helper/preference.dart';
import 'Network/internet_connection_check.dart';
import 'Utils/constants.dart';
import 'View/Splash/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceManager.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light, // White icons
    statusBarColor: Colors.transparent, // Optional: Make the status bar transparent
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    InternetChecker().startMonitoring();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavigationBarScreenViewModel()),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MaterialApp(
          title: 'Washionic Driver',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColor.appPrimaryColor),
          ),
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          home: SplashScreen(),
        ),
      ),
    );
  }
}
