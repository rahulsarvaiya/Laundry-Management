import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../Style/Fonts.dart';
import '../../Utils/Constants.dart';
import '../Helper/assets_helper.dart';
import '../Style/app_theme.dart';
import '../Utils/common_widget.dart';

class ButtonView extends StatelessWidget {
   ButtonView({
    super.key,
    this.buttonTextName,
    this.onPressed,
    this.width,
    this.margin,
    this.color,
    this.height,
    this.style,
    this.borderRadius,
    this.borderColor,
    this.progressBarColor,
    this.borderWidth,
    this.vnIsShowLoader,
    this.showSuffixIcon = false,
    this.showPrefixIcon = false,
    this.prefixIcon,
    this.prefixIconSize,
    this.prefixIconColor,
    this.suffixIcon,
  });

  final String? buttonTextName;
  final Function? onPressed;
  final double? height;
  final double? width;
  final double? borderRadius;
  final TextStyle? style;
  final double? margin;
  final Color? color;
  final Color? borderColor;
  final double? borderWidth;
  final String? prefixIcon;
  final double? prefixIconSize;
  final Color? prefixIconColor;
  final Color? progressBarColor;
  final String? suffixIcon;
  final bool? showSuffixIcon;
  final bool? showPrefixIcon;
  ValueNotifier<bool>? vnIsShowLoader = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if (vnIsShowLoader != null) {
          if (!vnIsShowLoader!.value) onPressed!();
        } else {
          onPressed!();
        }
      },
      child: Container(
        width: width ?? MediaQuery.of(context).size.width * 0.9,
        height: height ?? 50,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? padding_30),
          border: Border.all(color: borderColor ?? AppColor.appPrimaryColor, width: borderWidth ?? 1),
          color: color ?? AppColor.appPrimaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (vnIsShowLoader != null)
                ? ValueListenableBuilder(
                valueListenable: vnIsShowLoader!,
                builder: (context, val, child) {
                  return showPrefixIcon ?? false
                      ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: !vnIsShowLoader!.value,
                        child: SvgPicture.asset(
                          AssetsHelper.getSVGIcon(prefixIcon!),
                          height: prefixIconSize ?? 20,
                          color: prefixIconColor,
                          // colorFilter: ColorFilter.mode(prefixIconColor!, BlendMode.srcIn),
                        ),
                      ),
                      CommonWidget.getFieldSpacer(width: 10),
                    ],
                  )
                      : const SizedBox();
                })
                : showPrefixIcon ?? false
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetsHelper.getSVGIcon(prefixIcon!),
                  height: prefixIconSize ?? 20,
                  color: prefixIconColor,
                  // colorFilter: ColorFilter.mode(prefixIconColor!, BlendMode.srcIn),
                ),
                CommonWidget.getFieldSpacer(width: 10),
              ],
            )
                : const SizedBox(),
            Center(
              child: (vnIsShowLoader != null)
                  ? ValueListenableBuilder(
                valueListenable: vnIsShowLoader!,
                builder: (context, val, child) => Visibility(
                  visible: vnIsShowLoader!.value,
                  replacement: Row(
                    children: [
                      Text(
                        buttonTextName!,
                        style: style ?? Fonts.regularTextStyleSemiBold.copyWith(fontSize: 15, color: AppColor.appWhiteColor),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                      CommonWidget.getFieldSpacer(width: 10),
                      Visibility(
                          visible: showSuffixIcon!,
                          child: SvgPicture.asset(
                            AssetsHelper.getSVGIcon('ic_arrow_right.svg'),
                          )),
                    ],
                  ),
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation(progressBarColor ?? Colors.black),
                  ),
                ),
              )
                  : Text(
                buttonTextName!,
                style: style ?? Fonts.regularTextStyleSemiBold.copyWith(fontSize: 15, color: AppColor.appWhiteColor),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
