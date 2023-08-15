import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';

class DefaultLayout extends StatelessWidget {
  final String? title;
  final Widget? leading;
  final double? leadingWidth;
  final double? appbarHeight;
  final Widget? drawer;
  final Color backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget child;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const DefaultLayout({
    Key? key,
    this.title,
    this.leading,
    this.leadingWidth,
    this.appbarHeight,
    this.drawer,
    this.backgroundColor = Colors.white,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: backgroundColor,
      drawer: drawer,
      body: SafeArea(child: child),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: floatingActionButton,
    );
  }

  AppBar? _appBar() => title == null
      ? null
      : AppBar(
          toolbarHeight: appbarHeight,
          centerTitle: false,
          backgroundColor: CustomColor.mainColor,
          leading: leading,
          leadingWidth: leadingWidth,
          elevation: 0,
          title: Text(
            title!,
            style: kTextReverseStyleMiddle,
          ),
          foregroundColor: Colors.black,
        );
}
