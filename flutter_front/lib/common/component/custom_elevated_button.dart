import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget content;
  final Color color;
  final double borderRadiusCircular;
  late final double verticalPadding;
  late final double horizontalPadding;
  final void Function()? onPressed;

  CustomElevatedButton({
    super.key,
    required this.content,
    required this.onPressed,
    this.color = Colors.black,
    this.borderRadiusCircular = 20.0,
    double? horizontalPadding,
    double? verticalPadding,
  }) {
    this.horizontalPadding = horizontalPadding ?? kPaddingMiniSize.w;
    this.verticalPadding = verticalPadding ?? kPaddingSmallSize.w;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusCircular),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        child: content,
      ),
    );
  }
}
