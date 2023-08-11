import 'package:flutter/material.dart';
import 'package:flutter_front/auth/model/service/auth_service.dart';
import 'package:flutter_front/auth/model/state/auth_state.dart';
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

  const DefaultLayout({
    Key? key,
    this.title,
    this.leading,
    this.leadingWidth,
    this.appbarHeight,
    this.drawer,
    this.backgroundColor = Colors.white,
    this.bottomNavigationBar,
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
            ),
      backgroundColor: backgroundColor,
      drawer: drawer,
      body: SafeArea(child: child),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  // AppBar! _appBar() => title == null
  //     ? null
  //     : _CustomAppBar(
  //         appbarHeight: appbarHeight!,
  //         leading: leading!,
  //         leadingWidth: leadingWidth!,
  //         title: title!,
  //       );
}

class CustomMenuItem extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomMenuItem({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: kTextMainStyleSmall,
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final Widget leading;
  final double leadingWidth;
  final double appbarHeight;
  const _CustomAppBar({
    required this.appbarHeight,
    required this.leading,
    required this.leadingWidth,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final valueList = [
      PopupMenuItem<String>(
        child: CustomMenuItem(
          text: "logout",
          onPressed: ref.read(authServiceProvider.notifier).logout,
        ),
      ),
    ];
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
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${(ref.read(authServiceProvider) as AuthStateSuccess).data.userName}님 안녕하세요!",
              style: kTextReverseStyleMiddle,
            ),
          ],
        ),
        const SizedBox(
          width: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 15,
          ),
          child: PopupMenuButton<String>(
            icon: const Icon(
              Icons.person,
              color: CustomColor.textReverseColor,
            ),
            itemBuilder: (BuildContext context) {
              return valueList.map(
                (PopupMenuItem<String> choice) {
                  return choice;
                },
              ).toList();
            },
          ),
        ),
      ],
      foregroundColor: Colors.black,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appbarHeight); // Appbar 높이 지정
}
