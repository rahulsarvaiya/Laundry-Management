import 'package:driver/View/Splash/splash_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Helper/assets_helper.dart';
import '../../Style/app_theme.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashScreenViewModel splashScreenViewModel = SplashScreenViewModel();

  @override
  void initState() {
    super.initState();
    splashScreenViewModel.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => splashScreenViewModel,
      child: Consumer(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: AppColor.appPrimaryColor,
            body: Center(child: AssetsHelper.getAssetImage(name: 'app_logo.jpeg'),),
          );
        },
      ),
    );
  }
}
