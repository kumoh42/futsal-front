import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitledText extends StatelessWidget {
  final String title;
  final String text;

  const TitledText({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: kTextDisabledStyle.copyWith(fontSize: kTextMiddleSize.sp),
        ),
        Text(
          text,
          style: kTextDisabledStyle.copyWith(fontSize: kTextMiddleSize.sp),
        ),
      ],
    );
  }
}
