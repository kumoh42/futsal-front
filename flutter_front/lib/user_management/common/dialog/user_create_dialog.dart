import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_front/common/component/base_dialog.dart';
import 'package:flutter_front/common/component/container/responsive_container.dart';
import 'package:flutter_front/common/component/custom_dropdown_menu.dart';
import 'package:flutter_front/common/component/custome_titled_text.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/reservation_status/component/designed_button.dart';
import 'package:flutter_front/user_management/common/info_list.dart';
import 'package:flutter_front/user_management/model/entity/user_info_entity.dart';

class UserCreateDialog extends StatelessWidget {
  final Future Function(UserInfo user) onPressed;
  const UserCreateDialog({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final idTextController = TextEditingController();
    final nameTextController = TextEditingController();
    final circleTextController = TextEditingController();
    final authController = CustomDropDownMenuController(menuList: authList);
    final majorController = CustomDropDownMenuController(menuList: majorList);

    return Form(
      key: formKey,
      child: BaseDialog(
        title: "사용자 추가",
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
                  content: customTextField(controller: idTextController),
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
                        content:
                            customTextField(controller: circleTextController),
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
                      text: '저장',
                      icon: Icons.save,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (context.mounted) {
                            onPressed(
                              UserInfo(
                                circle_circle_name: circleTextController.text,
                                major_major_name: majorController.selected,
                                member_member_srl: idTextController.text,
                                member_permission: authController.selected,
                                member_user_name: nameTextController.text,
                                member_phone_number: "010-1234-1234",
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

Widget customTextField({TextEditingController? controller}) {
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
