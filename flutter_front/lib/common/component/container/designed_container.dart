import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/common/styles/sizes.dart';

import 'designed_container_title_bar.dart';

class DesignedContainer extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final Widget child;

  const DesignedContainer({
    Key? key,
    required this.title,
    this.actions,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kBackgroundMainColor,
        border: Border.all(color: kDisabledColor, width: 3),
        borderRadius: const BorderRadius.all(
          Radius.circular(kBorderRadiusSize),
        ),
      ),
      padding: const EdgeInsets.all(kPaddingLargeSize),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DesignedContainerTitleBar(title: title, actions: actions),
          const SizedBox(height: kPaddingMiddleSize),
          child,
        ],
      ),
    );
  }
}
