import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DefaultLayout extends StatelessWidget {
  final String? title;
  final Widget? leading;
  final double? leadingWidth;
  final double? appbarHeight;
  final Widget? drawer;
  final Color backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget child;
  final List<Widget>? actions;

  const DefaultLayout({
    Key? key,
    this.title,
    this.leading,
    this.leadingWidth,
    this.appbarHeight,
    this.drawer,
    this.backgroundColor = Colors.white,
    this.bottomNavigationBar,
    this.actions,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title == null
          ? null
          : _CustomAppBar(
              appbarHeight: appbarHeight!,
              leading: leading!,
              leadingWidth: leadingWidth!,
              title: title!,
              actions: actions,
            ),
      backgroundColor: backgroundColor,
      drawer: drawer,
      body: SafeArea(child: child),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

class _CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final Widget leading;
  final double leadingWidth;
  final double appbarHeight;
  final List<Widget>? actions;
  const _CustomAppBar({
    this.actions,
    required this.appbarHeight,
    required this.leading,
    required this.leadingWidth,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      toolbarHeight: appbarHeight,
      centerTitle: false,
      backgroundColor: CustomColor.mainColor,
      leading: leading,
      leadingWidth: leadingWidth,
      elevation: 0,
      title: Text(
        title,
        style: kTextReverseStyleMiddle,
      ),
      actions: actions,
      foregroundColor: Colors.black,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appbarHeight); // Appbar 높이 지정
}
