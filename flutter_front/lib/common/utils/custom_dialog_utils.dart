import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/text_styles.dart';

class CustomDialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final String? cancel;
  final String? accept;
  final VoidCallback onPressed;
  const CustomDialog({
    super.key,
    this.content,
    this.cancel,
    this.accept,
    this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            cancel ?? "cancel",
            style: kTextMainStyleSmall,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            accept ?? "ok",
            style: kTextMainStyleSmall,
          ),
        ),
      ],
    );
  }
}