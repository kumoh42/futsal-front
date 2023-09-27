import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_front/common/component/base_dialog.dart';
import 'package:flutter_front/common/component/container/responsive_container.dart';
import 'package:flutter_front/common/component/custom_dropdown_menu.dart';
import 'package:flutter_front/common/component/custome_titled_text.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/reservation_status/component/designed_button.dart';
import 'package:flutter_front/user_management/common/info_list.dart';
import 'package:flutter_front/user_management/model/entity/user_info_entity.dart';
import 'package:flutter_front/user_management/viewmodel/user_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserCreateDialog extends ConsumerWidget {
  final Future Function(UserInfo user) onPressed;
  final bool isEdit;
  final UserInfo user;
  const UserCreateDialog({
    super.key,
    required this.onPressed,
    this.isEdit = false,
    required this.user,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(userListViewmodelProvider);
    final formKey = GlobalKey<FormState>();
    final idTextController = TextEditingController();
    final nameTextController = TextEditingController();
    final circleTextController =
        CustomDropDownMenuController(menuList: circleList);
    final phoneNumController = TextEditingController();
    final majorController = CustomDropDownMenuController(menuList: majorList);
    if (isEdit) {
      nameTextController.text = user.member_user_name;
      circleTextController.selected = user.circle_circle_name;
      phoneNumController.text = user.member_phone_number;
      majorController.selected = user.major_major_name;
    }

    return Form(
      key: formKey,
      child: BaseDialog(
        title: isEdit ? "사용자 정보 수정" : "사용자 추가",
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
                  content: isEdit
                      ? Text(
                          user.member_member_srl,
                        )
                      : customTextField(controller: idTextController),
                ),
                ResponsiveSizedBox(size: kPaddingLargeSize),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTitledText(
                        title: info[1],
                        content:
                            customTextField(controller: nameTextController),
                      ),
                    ),
                    ResponsiveSizedBox(size: kPaddingLargeSize),
                    Expanded(
                      child: CustomTitledText(
                        title: info[4],
                        content:
                            customTextField(controller: phoneNumController),
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
                      child: CustomDropDownMenu(
                        title: info[2],
                        menuTextStyle: kTextNormalStyle.copyWith(
                          fontSize: kTextMiddleSize,
                        ),
                        controller: circleTextController,
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
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
                ResponsiveSizedBox(size: kPaddingXLargeSize),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (isEdit)
                      DesignedButton(
                        text: '삭제',
                        icon: Icons.delete_outline,
                        color: kPointColor,
                        onPressed: () async {
                          final res = await viewmodel.removeUser(context);
                          if (res && context.mounted) {
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    if (isEdit) ResponsiveSizedBox(size: kPaddingMiddleSize),
                    DesignedButton(
                      text: '저장',
                      icon: Icons.save,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (context.mounted) {
                            onPressed(
                              UserInfo(
                                circle_circle_name:
                                    circleTextController.selected,
                                major_major_name: majorController.selected,
                                member_member_srl: idTextController.text,
                                member_permission: phoneNumController.text,
                                member_user_name: nameTextController.text,
                                member_phone_number: phoneNumController.text,
                              ),
                            );
                            Navigator.of(context).pop();
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget customTextField({TextEditingController? controller, String? defalut}) {
  return TextFormField(
    validator: (value) {
      if (value!.isEmpty) {
        return '값을 입력해주세요';
      }

      return null;
    },
    controller: controller,
    decoration: const InputDecoration(
      isDense: true,
    ),
    style: kTextNormalStyle.copyWith(
      fontSize: kTextMiddleSize,
    ),
    autovalidateMode: AutovalidateMode.always,
    inputFormatters: [
      FilteringTextInputFormatter.deny(RegExp(r'\s')), // 공백 입력을 막습니다.
    ],
  );
}
