import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';

class CustomContainer extends StatelessWidget {
  final String? title;
  final double? width;
  final double? height;
  final double? minWidth;
  final double? minHeight;
  final Color? color;
  final Widget child;

  const CustomContainer({
    Key? key,
    this.title,
    this.width,
    this.height,
    this.minWidth,
    this.minHeight,
    this.color,
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
      ),
      child: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(kBorderRadiusSize)),
        ),
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(kPaddingMiddleSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              title != null
                  ? Text(title!, style: kTextMainStyleLarge)
                  : Container(),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
