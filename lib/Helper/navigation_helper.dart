import 'package:flutter/material.dart';


import '../Utils/constants.dart';

enum AnimationType {
  slideLeft,
  slideRight,
  slideUp,
  slideDown,
}

class NavigatorHelper {

  add(Widget widget, {Function? callback, AnimationType? animationType = AnimationType.slideLeft}) {
    FocusManager.instance.primaryFocus!.unfocus();

    if (animationType == AnimationType.slideLeft) {
      navigatorKey.currentState!
          .push(slideLeft(widget))
          .then((dynamic value) {
        if (callback != null && value != null) callback(value);
      });
    } else if (animationType == AnimationType.slideRight) {
      navigatorKey.currentState!
          .push(slideRight(widget))
          .then((dynamic value) {
        if (callback != null && value != null) callback(value);
      });
    } else if (animationType == AnimationType.slideUp) {
      navigatorKey.currentState!
          .push(slideUp(widget))
          .then((dynamic value) {
        if (callback != null && value != null) callback(value);
      });
    } else if (animationType == AnimationType.slideDown) {
      navigatorKey.currentState!
          .push(slideDown(widget))
          .then((dynamic value) {
        if (callback != null && value != null) callback(value);
      });
    }

  }

  static showGeneralPopUp(BuildContext context, Widget child, {Function? callback}) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: child,
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (BuildContext buildContext, animation, secondaryAnimation) {
        return SizedBox();
      },
    );
  }





  static replace(Widget widget, {Function? callback}) {
    navigatorKey.currentState!
        .pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    ))
        .then((value) {
      if (callback != null && value != null) callback(value);
    });
  }

  static remove({dynamic value}) {
    print("remove $value");
    navigatorKey.currentState!.pop(value ?? false);
  }

  static removeAllAndOpen(Widget widget) {
    navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => widget),
          (Route<dynamic> route) => false,
    );
  }

  static openDialog(Widget widget, {Function? callback}) {
    navigatorKey.currentState!
        .push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, animation, _) {
        return widget;
      },
    ))
        .then((value) {
      if (callback != null) {
        callback(value);
      }
    });
  }

  static void openBottomSheet(BuildContext context, Widget widget, {Function? callback, borderRadius}) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(child: widget);
        });
  }

  static void openBottomSheetWithScroll(BuildContext context, Widget widget, {Function? callback}) {
    showModalBottomSheet(
        enableDrag: false,
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: widget,
          );
        });
  }

  slideLeft(Widget nextScreen) {
    return PageRouteBuilder(
        pageBuilder: ((context, animation, secondaryAnimation) => nextScreen),
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }

  slideRight(Widget nextScreen) {
    return PageRouteBuilder(
        pageBuilder: ((context, animation, secondaryAnimation) => nextScreen),
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }

  slideUp(Widget nextScreen) {
    return PageRouteBuilder(
        pageBuilder: ((context, animation, secondaryAnimation) => nextScreen),
        transitionDuration:
        const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }

  slideDown(Widget nextScreen) {
    return PageRouteBuilder(
        pageBuilder: ((context, animation, secondaryAnimation) => nextScreen),
        transitionDuration:
        const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, -1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }

}
