import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/container/responsive_container.dart';
import 'package:flutter_front/common/component/custom_dropdown_menu.dart';
import 'package:flutter_front/common/component/custome_titled_text.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/reservation_status/component/designed_button.dart';
import 'package:flutter_front/common/component/base_dialog.dart';
import 'package:flutter_front/user_management/common/info_list.dart';
import 'package:flutter_front/user_management/viewmodel/user_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfoEditDialog extends ConsumerWidget {
  const UserInfoEditDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(userListViewmodelProvider);
    return BaseDialog(
      title: "사용자 정보 수정",
      child: SizedBox(
        width: ResponsiveSize.W(500),
        child: Padding(
          padding: EdgeInsets.all(kPaddingLargeSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveSizedBox(size: kPaddingLargeSize),
              CustomTitledText(
                title: "아이디",
                content: viewmodel.userList![viewmodel.selectedIndex].id,
              ),
              ResponsiveSizedBox(size: kPaddingLargeSize),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomTitledText(
                      title: "이름",
                      content:
                          viewmodel.userList![viewmodel.selectedIndex].name,
                    ),
                  ),
                  ResponsiveSizedBox(size: kPaddingLargeSize),
                  Expanded(
                    child: CustomDropDownMenu(
                      title: "권한",
                      menuTextStyle: kTextNormalStyle.copyWith(
                        fontSize: kTextMiddleSize,
                      ),
                      controller: CustomDropDownMenuController(
                        menuList: authList,
                      ),
                      titleSize: kTextMiniSize,
                    ),
                  ),
                  const SizedBox(),
                ],
              ),
              ResponsiveSizedBox(size: kPaddingLargeSize),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomTitledText(
                      title: "닉네임",
                      content:
                          viewmodel.userList![viewmodel.selectedIndex].nickName,
                    ),
                  ),
                  ResponsiveSizedBox(size: kPaddingLargeSize),
                  Expanded(
                    child: CustomDropDownMenu(
                      title: "소속",
                      menuTextStyle: kTextNormalStyle.copyWith(
                        fontSize: kTextMiddleSize,
                      ),
                      controller: CustomDropDownMenuController(
                        menuList: majorList,
                      ),
                      titleSize: kTextMiniSize,
                    ),
                  ),
                  const SizedBox(),
                ],
              ),
              ResponsiveSizedBox(size: kPaddingXLargeSize),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DesignedButton(
                      text: '삭제',
                      icon: Icons.delete_outline,
                      color: kPointColor,
                      onPressed: () async {
                        final res = await viewmodel.removeUser(context);
                        if (res && context.mounted) Navigator.of(context).pop();
                      }),
                  ResponsiveSizedBox(size: kPaddingMiddleSize),
                  DesignedButton(
                    text: '저장',
                    icon: Icons.save,
                    onPressed: () {
                      viewmodel.editUser(context);
                      if (context.mounted) Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
