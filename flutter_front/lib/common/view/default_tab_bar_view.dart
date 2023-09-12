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
    // 가로 스크롤을 위함
    final horizontalScrollController = ScrollController();
    return LayoutBuilder(
        // SingleChildScrollView-> 세로 스크롤을 위함
        builder: (context, constrains) {
      return SingleChildScrollView(
        // Scrollbar->사용자가 스크롤할 때 어디에 위치해 있는지를 시각적으로 보여주는 역할
        child: Scrollbar(
          controller: horizontalScrollController,
          // 가로 스크롤을 위함
          child: SingleChildScrollView(
            controller: horizontalScrollController,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: isExpanded
                  ? constrains.maxWidth
                  : kLayoutWidthSize,
              child: child,
            ),
          ),
        ),
      );
    });
  }
}
