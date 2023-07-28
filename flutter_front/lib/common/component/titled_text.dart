import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';

class TitledText extends StatelessWidget {
  final String? title;
  final String? text;

  final IconData? prefixIcon;

  const TitledText({
    Key? key,
    this.title,
    this.text,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: CustomColor.mainColor,
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (prefixIcon != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: kPaddingMiddleSize,
                  ),
                  child: Icon(prefixIcon,
                      size: kIconMiddleSize, color: CustomColor.itemSubColor),
                ),
              Text(title ?? "", style: kTextMainStyleSmall),
            ],
          ),
          Text(text ?? "", style: kTextMainStyleMiddle),
        ],
      ),
    );
  }
}
