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
import 'package:flutter_front/user_management/model/entity/user_info_entity.dart';
import 'package:flutter_front/user_management/viewmodel/user_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfoEditDialog extends ConsumerWidget {
  const UserInfoEditDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(userListViewmodelProvider);
    final selectedUser = viewmodel.userList![viewmodel.selectedIndex];

    final authController = CustomDropDownMenuController(
        menuList: authList, selected: selectedUser.member_permission);
    final majorController = CustomDropDownMenuController(
        menuList: majorList, selected: selectedUser.major_major_name);

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
                title: info[0],
                content: Text(
                  selectedUser.member_member_srl,
                  style: kTextNormalStyle.copyWith(
                    fontSize: kTextMiddleSize,
                  ),
                ),
              ),
              ResponsiveSizedBox(size: kPaddingLargeSize),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomTitledText(
                      title: info[1],
                      content: Text(
                        selectedUser.member_user_name,
                        style: kTextNormalStyle.copyWith(
                          fontSize: kTextMiddleSize,
                        ),
                      ),
                    ),
                  ),
                  ResponsiveSizedBox(size: kPaddingLargeSize),
                  Expanded(
                    child: CustomDropDownMenu(
                      title: info[4],
                      menuTextStyle: kTextNormalStyle.copyWith(
                        fontSize: kTextMiddleSize,
                      ),
                      controller: authController,
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
                      title: info[2],
                      content: Text(
                        selectedUser.circle_circle_name,
                        style: kTextNormalStyle.copyWith(
                          fontSize: kTextMiddleSize,
                        ),
                      ),
                    ),
                  ),
                  ResponsiveSizedBox(size: kPaddingLargeSize),
                  Expanded(
                    child: CustomDropDownMenu(
                      title: info[3],
                      menuTextStyle: kTextNormalStyle.copyWith(
                        fontSize: kTextMiddleSize,
                      ),
                      controller: majorController,
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
                      viewmodel.editUser(
                        context,
                        UserInfo(
                          circle_circle_name: selectedUser.circle_circle_name,
                          major_major_name: majorController.selected,
                          member_member_srl: selectedUser.member_member_srl,
                          member_user_name: selectedUser.member_user_name,
                          member_permission: authController.selected,
                          member_phone_number: "010-8441-7112",
                          // authority: authController.selected,
                          // id: selectedUser.id,
                          // major: majorController.selected,
                          // name: selectedUser.name,
                          // nickName: selectedUser.nickName,
                        ),
                      );

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
