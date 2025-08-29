import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double splashRadius;
  final Widget child;
  final Color? backgroundColor;
  EdgeInsetsGeometry? padding;

  CustomTextButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.splashRadius = 25.0,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
      color: backgroundColor ?? Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20.0), // Match the border radius
        // splashColor: AppColor.appPrimaryColor.withOpacity(0.1), // Adjust the splash color opacity as needed
        splashFactory: InkRipple.splashFactory,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(8.0), // Adjust the padding as needed
          child: child,
        ),
      ),
    );
  }
}
