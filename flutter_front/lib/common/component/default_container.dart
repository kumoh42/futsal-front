import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';

class DefaultContainer extends StatelessWidget {
  final Color backgroundColor;
  final String? title;
  final List<Widget>? actions;
  final Widget body;
  final bool isExpanded;

  const DefaultContainer({
    Key? key,
    this.backgroundColor = kBackgroundMainColor,
    this.title,
    this.actions,
    this.isExpanded = false,
    required this.body,
  })  : assert(title != null || actions == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: title == null
          ? null
          : _DefaultLayoutAppBar(title: title!, actions: actions),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: Center(
              child: _DefaultLayoutContainer(
                margin: const EdgeInsets.symmetric(
                  vertical: kPaddingMiddleSize,
                ),
                height: (isExpanded
                        ? constraints.maxHeight
                        : min(constraints.maxWidth * 8 / 15, 850)) -
                    kPaddingMiddleSize * 2,
                child: body,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DefaultLayoutContainer extends Container {
  _DefaultLayoutContainer({super.margin, super.child, required double height})
      : super(
          constraints: BoxConstraints(
            maxWidth: kLayoutMaxSize,
            maxHeight: height,
          ),
          padding: const EdgeInsets.symmetric(horizontal: kLayoutMarginSize),
        );
}

class _DefaultLayoutAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final Color color = kBackgroundMainColor;
  final List<Widget>? actions;

  const _DefaultLayoutAppBar({
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: kPaddingSmallSize),
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(color: kDisabledColor, width: 1.0),
        ),
        color: color,
      ),
      child: Center(
        child: _DefaultLayoutContainer(
          height: kToolbarHeight,
          child: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            backgroundColor: color,
            titleSpacing: 0,
            leading: Transform.translate(
              offset: const Offset(-7.5, 3),
              child: Image.asset(
                'assets/image/black_logo.png',
                fit: BoxFit.cover,
              ),
            ),
            elevation: 0,
            title: Text(title, style: kTextMainStyleTitle),
            actions: actions?.expand(_addPadding).toList(),
            foregroundColor: Colors.black,
          ),
        ),
      ),
    );
  }

  Iterable<Widget> _addPadding(Widget element) =>
      [const SizedBox(width: kPaddingMiddleSize), element];

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
