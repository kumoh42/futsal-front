import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';

class CustomOutlinedButton extends StatelessWidget {
  final void Function()? onPressed;

  final String text;

  final Color color;

  final double? width;
  final double? height;
  final double? borderRadius;
  final double? elevation;

  final bool withSide;

  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color = CustomColor.buttonMainColor,
    this.width,
    this.height,
    this.borderRadius,
    this.elevation,
    this.withSide = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? kBorderRadiusSize),
          ),
          minimumSize: kOutlinedButtonSize,
          side: withSide ? const BorderSide(color: Colors.white, width: 1) : null,
          elevation: elevation ?? 0,
        ),
        child: Text(
          text,
          style: kTextReverseStyleMiddle,
        ),
      ),
    );
  }
}
