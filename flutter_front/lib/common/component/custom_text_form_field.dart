import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;

  final IconData? prefixIcon;

  final TextInputType keyboardType;

  final String? Function(String?)? validator;
  final TextEditingController? controller;

  final TextStyle? textStyle;
  late final double contentPadding;
  final Color? backgroundColor;

  CustomTextFormField({
    Key? key,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.controller,
    this.textStyle,
    double? contentPadding,
    this.backgroundColor,
  }) : super(key: key) {
    this.contentPadding = contentPadding ?? kPaddingMiddleSize;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? kBackgroundMainColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (prefixIcon != null)
                Icon(
                  prefixIcon,
                  size: kIconSmallSize,
                  color: kSubColor,
                ),
              if (prefixIcon != null) const SizedBox(width: kPaddingSmallSize),
              if (labelText != null)
                Text(
                  labelText!,
                  style: kTextMainStyleSmall,
                ),
            ],
          ),
          SizedBox(height: contentPadding),
          TextFormField(
            controller: controller,
            validator: validator,
            cursorColor: kTextMainColor,
            keyboardType: keyboardType,
            obscureText: keyboardType == TextInputType.visiblePassword,
            style: textStyle ?? kTextMainStyleMiddle,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'\s')), // 공백 입력 방지
            ],
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.only(bottom: contentPadding),
              hintText: hintText,
              hintStyle: textStyle?.copyWith(
                color: kTextMainColor.withOpacity(0.5),
              ) ?? kTextMainStyleMiddle.copyWith(
                color: kTextMainColor.withOpacity(0.5),
              ),
              filled: true,
              fillColor: backgroundColor ?? kBackgroundMainColor,
            ),
          ),
        ],
      ),
    );
  }
}
