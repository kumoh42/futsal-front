import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/text_styles.dart';

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
        Text(title, style: kTextDisabledStyleMiddle),
        Text(text, style: kTextMainStyleMiddle),
      ],
    );
  }
}
