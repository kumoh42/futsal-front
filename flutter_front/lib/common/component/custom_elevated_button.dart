import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget content;
  final Color color;
  final double borderRadiusCircular;
  final double verticalPadding;
  final double horizontalPadding;
  final void Function()? onPressed;
  const CustomElevatedButton({
    super.key,
    required this.content,
    required this.onPressed,
    this.color = Colors.black,
    this.borderRadiusCircular = 20.0,
    this.horizontalPadding = kPaddingMiniSize,
    this.verticalPadding = kPaddingSmallSize,
  });

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
