import 'package:driver/Helper/navigation_helper.dart';
import 'package:driver/Helper/pref_name.dart';
import 'package:driver/View/Login/login_screen.dart';
import 'package:flutter/material.dart';
import '../../Helper/preference.dart';

class IntroScreenViewModel extends ChangeNotifier{

  late BuildContext context;
  PageController pageController = PageController();
  int currentPage = 0;
  init(BuildContext context){
    this.context = context;
    notifyListeners();
  }

  changePage(int index){
    currentPage=index;
    notifyListeners();
  }

  List<Intro> allItems=[
    Intro(title: "Get started with", subTitle: "Delivery", description: "We can have a steady job and earn money.Welcome to the gathering of drivers!", image: "image_01.jpg"),
    Intro(title: "Open delivery app", subTitle: "Accepts & Starts", description: "Various trips are offered to you through the application", image: "image_02.jpeg"),
    Intro(title: "You can", subTitle: "Earn Money", description: "Earn up to \$2500 per month with the highest.Paying delivery app on the market", image: "image_03.jpg"),
  ];

  changeTab(){
    pageController.animateToPage(currentPage, duration: Duration(milliseconds: 200), curve: Curves.ease);
  }

  navigationToLogin(){
    PreferenceManager.setBoolean(PrefName.intro, true);
    NavigatorHelper.removeAllAndOpen(LoginScreen());
  }
}

class Intro{
  String title;
  String subTitle;
  String description;
  String image;

  Intro({required this.title, required this.subTitle, required this.description, required this.image});
}