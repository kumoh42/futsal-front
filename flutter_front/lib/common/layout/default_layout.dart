import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/colors.dart';

class DefaultLayout extends StatelessWidget {
  final String? title;
  final Widget? leading;
  final double? leadingWidth;
  final Widget? drawer;
  final Color backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget child;

  const DefaultLayout({
    Key? key,
    this.title,
    this.leading,
    this.leadingWidth,
    this.drawer,
    this.backgroundColor = Colors.white,
    this.bottomNavigationBar,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: backgroundColor,
      drawer: drawer,
      body: SafeArea(
        child: child,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? _appBar() => title == null
      ? null
      : AppBar(
          centerTitle: true,
          backgroundColor: CustomColor.mainColor,
          leading: leading,
          leadingWidth: leadingWidth,
          elevation: 0,
          title: Text(
            title!,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          foregroundColor: Colors.black,
        );
}
