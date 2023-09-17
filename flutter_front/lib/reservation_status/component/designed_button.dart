import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DesignedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String text;
  final Color color;

  const DesignedButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.text,
    this.color = kMainColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadiusSize * 2),
        ),
        elevation: 0.0,
        padding: EdgeInsets.symmetric(
          horizontal: kPaddingMiddleSize.w,
          vertical: kPaddingLargeSize.w,
        ),
      ),
      child: Row(
        children: [
          Transform.translate(
            offset: const Offset(-5, 0),
            child: Icon(icon, size: kIconMiddleSize.w, color: kTextReverseColor),
          ),
          Text(
            text,
            style: kTextReverseStyle.copyWith(fontSize: kTextMiddleSize.sp),
          ),
        ],
      ),
    );
  }
}
