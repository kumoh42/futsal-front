import 'package:flutter/material.dart';
import 'package:flutter_front/common/const_styles/colors.dart';
import 'package:flutter_front/common/const_styles/sizes.dart';

class CustomOkButton extends StatelessWidget {
  final void Function() onPressed;
  final double width;
  final Color color;
  final Icon icon;
  final Text text;

  const CustomOkButton({
    super.key,
    required this.text,
    required this.icon,
    this.color = kMainColor,
    this.width = 0,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: kPaddingMiddleSize,
          vertical: kPaddingMiddleSize,
        ),
      ),
      child: SizedBox(
        width: width == 0 ? null : width,
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: kPaddingSmallSize,
            ),
            text,
          ],
        ),
      ),
    );
  }
}
