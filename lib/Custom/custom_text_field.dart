import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../Helper/assets_helper.dart';
import '../Style/Fonts.dart';
import '../Style/app_theme.dart';
import '../Style/borders.dart';


class CustomTextField extends StatefulWidget {
  late final TextEditingController tecController;
  late final FocusNode focusNode;
  late final TextInputType? textInputType;
  late final String? hintText, prefixIcon, errorText;
  final FormFieldValidator? validator;
  List<TextInputFormatter>? inputFormatters = [];
  bool? enableSuggestions = false;
  bool? isShowSuffixIcon = false;
  bool? showSuffixDivider = false;
  bool? isShowPrefixIcon = false;
  bool? showCursor = true;
  bool? readOnly = false;
  bool? enableInteractiveSelection;
  final TextInputAction? textInputAction;
  int? maxLines, minLines, maxLength, height;
  double? paddingTop, paddingBottom, paddingLeft, paddingRight;
  double? suffixIconHeight, suffixPaddingTop, suffixPaddingBottom, suffixPaddingLeft, suffixPaddingRight, prefixIconHeight;
  double? contentPaddingTop, contentPaddingBottom, contentPaddingLeft, contentPaddingRight;
  bool? isPassword = false;
  Color? fillColor;
  bool? enabled = true;
  Function? onTap, onTapOutSide;
  OutlineInputBorder? enabledBorder, focusedBorder, focusedErrorBorder, errorBorder;
  TextStyle? style, hintStyle, errorStyle;
  BoxDecoration? suffixIconDecoration;
  Border? suffixIconBorder;
  String? suffixIcon;
  String? obscuringCharacter;
  Color? suffixIconColor;
  Function? onTapSuffixIcon;
  Widget? prefixIconWidget;

  CustomTextField({
    super.key,
    required this.tecController,
    required this.focusNode,
    required this.hintText,
    this.errorText,
    this.prefixIcon,
    this.prefixIconWidget,
    this.validator,
    this.inputFormatters,
    this.textInputType,
    this.enableSuggestions,
    this.isShowSuffixIcon,
    this.showSuffixDivider,
    this.isShowPrefixIcon,
    this.textInputAction,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.height,
    this.fillColor,
    this.paddingTop,
    this.paddingBottom,
    this.paddingLeft,
    this.paddingRight,
    this.contentPaddingTop,
    this.contentPaddingBottom,
    this.contentPaddingRight,
    this.contentPaddingLeft,
    this.enabled = true,
    this.onTap,
    this.onTapOutSide,
    this.enabledBorder,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.errorBorder,
    this.isPassword = false,
    this.errorStyle,
    this.style,
    this.hintStyle,
    this.suffixIconDecoration,
    this.suffixIconBorder,
    this.suffixIcon,
    this.suffixIconColor,
    this.suffixIconHeight,
    this.prefixIconHeight,
    this.suffixPaddingBottom,
    this.suffixPaddingRight,
    this.suffixPaddingLeft,
    this.suffixPaddingTop,
    this.onTapSuffixIcon,
    this.showCursor,
    this.readOnly,
    this.obscuringCharacter,
    this.enableInteractiveSelection,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool rxHasFocus = false, rxShowText = true;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      _onFocusChange();
    });
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  _onFocusChange() {
    setState(() {
      rxHasFocus = !rxHasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      onTapOutside: (event) {
        widget.focusNode.unfocus();
        // if (widget.onTapOutSide != null) {
        //   widget.onTapOutSide!();
        // }
      },
      focusNode: widget.focusNode,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      showCursor: widget.showCursor,
      readOnly: widget.readOnly ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textCapitalization: TextCapitalization.none,
      controller: widget.tecController,
      keyboardType: widget.textInputType ?? TextInputType.text,
      style: widget.style ?? Fonts.regularTextStyle.copyWith(color: Colors.black),
      autocorrect: true,
      cursorColor: AppColor.appPrimaryColor,
      cursorHeight: 24,
      enableSuggestions: widget.enableSuggestions ?? true,
      maxLines: widget.maxLines ?? 1,
      minLines: widget.minLines ?? 1,
      maxLength: widget.maxLength,
      obscureText: widget.isPassword == true ? rxShowText : false,
      obscuringCharacter: widget.obscuringCharacter ?? '•',
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      textAlignVertical: TextAlignVertical.center,
      enableInteractiveSelection: widget.enableInteractiveSelection??false,
      decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor ?? AppColor.appWhiteColor,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ?? Fonts.regularTextStyle.copyWith(color: Colors.grey, fontSize: 15),
          errorStyle: widget.errorStyle ?? Fonts.regularTextStyleLight.copyWith(fontSize: 13, color: Colors.red),
          errorMaxLines: 3,
          contentPadding: EdgeInsets.fromLTRB(widget.contentPaddingLeft ?? 10.0, widget.contentPaddingTop ?? 5.0, widget.contentPaddingRight ?? 5.0,
              widget.contentPaddingBottom ?? 5.0),
          errorText: widget.errorText,
          counterText: '',
          prefixIconConstraints: const BoxConstraints(
            minWidth: 25,
            minHeight: 25,
          ),
          prefixIcon: widget.isShowPrefixIcon == true
              ? Padding(
            padding: EdgeInsets.only(
                top: widget.paddingTop ?? 5,
                left: widget.paddingLeft ?? 10,
                right: widget.paddingRight ?? 10,
                bottom: widget.paddingBottom ?? 5),
            child: widget.prefixIconWidget ??
                Padding(
                  padding: EdgeInsets.only(
                      top: widget.paddingTop ?? 5,
                      left: widget.paddingLeft ?? 10,
                      right: widget.paddingRight ?? 10,
                      bottom: widget.paddingBottom ?? 5),
                  child: SvgPicture.asset(
                    AssetsHelper.getSVGIcon(widget.prefixIcon!),
                    // color: rxHasFocus ? AppColor.appPrimaryColor : AppColor.appBlackColor,
                    colorFilter: ColorFilter.mode( rxHasFocus ? AppColor.appPrimaryColor : Colors.grey, BlendMode.srcIn),
                    height: widget.prefixIconHeight,
                  ),
                ),
          )
              : null,
          suffixIcon: widget.isShowSuffixIcon == true
              ? Container(
            padding: const EdgeInsets.only(top: 15, left: 5, right: 5, bottom: 15),
            decoration: widget.showSuffixDivider ?? false
                ? BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: rxHasFocus ? AppColor.appPrimaryColor : Colors.black,
                    width: 2,
                  ),
                ))
                : null,
            child: InkWell(
              onTap: () {
                setState(() {
                  rxShowText = rxShowText ? false : true;
                  // widget.tecController.clear();
                  // widget.onTapSuffixIcon!();
                });
              },
              child: Padding(
                padding: EdgeInsets.only(
                  top: widget.suffixPaddingTop ?? 0,
                  left: widget.suffixPaddingLeft ?? 0,
                  right: widget.suffixPaddingRight ?? 0,
                  bottom: widget.suffixPaddingBottom ?? 0,
                ),
                child: SvgPicture.asset(
                  AssetsHelper.getSVGIcon(widget.suffixIcon ?? (rxShowText ? 'ic_password_visible.svg' : 'ic_password_hidden.svg')),
                  // color: rxHasFocus ? AppColor.appPrimaryColor : AppColor.grey,
                  colorFilter: ColorFilter.mode( rxHasFocus ? AppColor.appPrimaryColor : Colors.grey, BlendMode.srcIn),
                  height: widget.suffixIconHeight ?? 15,
                ),
              )
              /*SvgPicture.asset(
                      rxShowText ? AssetsHelper.getSVGIcon('ic_eye_off.svg') : AssetsHelper.getSVGIcon('ic_eye.svg'),
                      color: AppColor.appGrey,
                    )*/
              ,
            ),
          )
              : null,
          focusedBorder: widget.focusedBorder ?? Borders.focusBorder,
          focusedErrorBorder: widget.focusedErrorBorder ?? Borders.errorBorder,
          enabledBorder: widget.enabledBorder ?? Borders.enableBorder,
          disabledBorder: widget.enabledBorder ?? Borders.enableBorder,
          errorBorder: widget.errorBorder ?? Borders.errorBorder),
    );
  }
}
