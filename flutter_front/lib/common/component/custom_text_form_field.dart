import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    this.contentPadding = contentPadding ?? kPaddingMiddleSize.w;
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
                  size: kIconSmallSize.w,
                  color: kSubColor,
                ),
              if (prefixIcon != null) SizedBox(width: kPaddingSmallSize.w),
              if (labelText != null)
                Text(
                  labelText!,
                  style: kTextMainStyle.copyWith(fontSize: kTextSmallSize.sp),
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
            style: textStyle ??
                kTextMainStyle.copyWith(
                  fontSize: kTextMiddleSize.sp,
                ),
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'\s')), // 공백 입력 방지
            ],
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.only(bottom: contentPadding),
              hintText: hintText,
              hintStyle: textStyle?.copyWith(
                    color: kTextMainColor.withOpacity(0.5),
                  ) ??
                  kTextMainStyle.copyWith(
                    fontSize: kTextMiddleSize.sp,
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
