import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/sizes.dart';

class DefaultTabBarView extends StatelessWidget {
  final Widget child;
  final bool isExpanded;

  const DefaultTabBarView({
    Key? key,
    this.isExpanded = false,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final horizontalScrollController = ScrollController();
    return LayoutBuilder(
      builder: (context, constrains) => SingleChildScrollView(
        child: Scrollbar(
          controller: horizontalScrollController,
          child: SingleChildScrollView(
            controller: horizontalScrollController,
            scrollDirection: Axis.horizontal,
            child: Container(
              width: isExpanded
                  ? constrains.maxWidth
                  : kLayoutWidthSize - kNavigationRailSize,
              constraints: BoxConstraints(minHeight: constrains.maxHeight),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
