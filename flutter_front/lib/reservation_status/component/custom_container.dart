import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';

class CustomContainer extends StatelessWidget {
  final String? title;
  final double? width;
  final double? height;
  final double? minWidth;
  final double? minHeight;
  final double? maxWidth;
  final double? maxHeight;
  final double? boarderRadius;
  final Color? color;
  final bool isBackground;
  final Widget child;

  const CustomContainer({
    Key? key,
    this.title,
    this.width,
    this.height,
    this.minWidth,
    this.minHeight,
    this.maxWidth,
    this.maxHeight,
    this.boarderRadius,
    this.color,
    this.isBackground = false,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      constraints: BoxConstraints(
        minWidth: minWidth ?? 500,
        minHeight: minHeight ?? 0,
        maxWidth: maxWidth ?? double.infinity,
        maxHeight: maxHeight ?? double.infinity,
      ),
      child: Card(
        elevation: isBackground ? 0 : 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(boarderRadius ?? kBorderRadiusSize),
          ),
        ),
        color: color,
        child: Padding(
          padding: EdgeInsets.all(isBackground ? 0 : kPaddingMiddleSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null) Text(title!, style: kTextMainStyleLarge),
              if (title != null) const SizedBox(height: kPaddingMiddleSize),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
