import 'package:flutter/material.dart';
import 'package:flutter_front/common/const/tabs.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/common/view/root_tab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabButton extends ConsumerWidget {
  final TabInfo tabInfo;

  const TabButton({
    Key? key,
    required this.tabInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(rootTabIndexProvider);
    return TextButton(
      onPressed: () =>
          ref.read(rootTabIndexProvider.notifier).state = TABS.indexOf(tabInfo),
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: TABS[currentIndex] == tabInfo
            ? LinearBorder.bottom(
                side: const BorderSide(color: kTextMainColor, width: 2.0),
              )
            : null,
      ),
      child: Text(
        tabInfo.label,
        style: TABS[currentIndex] == tabInfo
            ? kTextMainStyle.copyWith(fontSize: kTextMiddleSize.sp)
            : kTextMainStyle.copyWith(
                fontSize: kTextMiddleSize.sp,
                color: kDisabledColor,
              ),
      ),
    );
  }
}
