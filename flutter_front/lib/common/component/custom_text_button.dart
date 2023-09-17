import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextButton extends StatelessWidget {
  final void Function()? onPressed;

  final String text;
  final TextAlign textAlign;

  const CustomTextButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.textAlign = TextAlign.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
        minimumSize: Size.fromHeight(kTextSmallSize.sp),
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        text,
        textAlign: textAlign,
        style: kTextDisabledStyle.copyWith(fontSize: kTextSmallSize.sp),
      ),
    );
  }
}
