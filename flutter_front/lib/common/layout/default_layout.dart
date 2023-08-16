import 'package:flutter/material.dart';
import 'package:flutter_front/auth/model/service/auth_service.dart';
import 'package:flutter_front/auth/model/state/auth_state.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/common/utils/custom_dialog_utils.dart';
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
            top: 2,
          ),
          child: IconButton(
            icon: const Icon(
              Icons.logout,
            ),
            iconSize: 20,
            splashRadius: 25,
            color: CustomColor.textReverseColor,
            onPressed: () {
              CustomDialogUtil.showCustomDialog(
                context: context,
                dialog: CustomDialog(
                  onPressed: ref.read(authServiceProvider.notifier).logout,
                  accept: "logout",
                  content: const Text(
                    "정말 로그아웃 하시겠습니까?",
                    style: kTextNormalStyleMiddle,
                  ),
                ),
              );
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
