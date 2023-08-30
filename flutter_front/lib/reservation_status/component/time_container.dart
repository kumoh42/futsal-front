import 'package:flutter/material.dart';

class TimeContainer extends StatelessWidget {
  final String content;
  const TimeContainer({
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[400]!,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          content,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
