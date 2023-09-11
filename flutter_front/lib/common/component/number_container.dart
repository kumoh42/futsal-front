import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/text_styles.dart';

class NumberContainer extends StatelessWidget {
  final String content;
  final double width;
  final double height;

  NumberContainer({
    super.key,
    required this.content,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          content,
          style: kTextMainStyleMiddle,
        ),
      ),
    );
  }
}
