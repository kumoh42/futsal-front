import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';

class CustomContainer extends StatelessWidget {
  final String? title;
  final Widget? leading;
  final double? width;
  final double? height;
  final double? minWidth;
  final double? minHeight;
  final double? maxWidth;
  final double? maxHeight;
  final Color? color;
  final bool isBackground;
  final Widget child;

  const CustomContainer({
    Key? key,
    this.title,
    this.leading,
    this.width,
    this.height,
    this.minWidth,
    this.minHeight,
    this.maxWidth,
    this.maxHeight,
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
        shape: isBackground
            ? null
            : const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(kBorderRadiusSize)),
              ),
        color: color,
        child: Padding(
          padding: EdgeInsets.all(isBackground ? 0 : kPaddingMiddleSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              title != null || leading != null
                  ? Row(
                      children: [
                        leading != null
                            ? Row(children: [
                                leading!,
                                const SizedBox(width: kPaddingMiddleSize),
                              ])
                            : Container(),
                        Text(title!, style: kTextMainStyleLarge),
                      ],
                    )
                  : Container(),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
