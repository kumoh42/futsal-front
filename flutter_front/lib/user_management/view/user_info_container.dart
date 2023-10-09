import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/container/designed_container.dart';
import 'package:flutter_front/common/component/custom_icon_button.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/user_management/model/entity/user_info_entity.dart';
import 'package:flutter_front/user_management/model/state/user_list_state.dart';
import 'package:flutter_front/user_management/view/user_info_content.dart';
import 'package:flutter_front/user_management/viewmodel/user_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfoContainer extends ConsumerWidget {
  const UserInfoContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(userListViewmodelProvider);
    final isShow = viewmodel.selectedIndex >= 0;
    return DesignedContainer(
      title: "사용자 정보",
      actions: [
        CustomIconButton(
          hintMessage: "사용자 정보 수정",
          icon: Icons.edit,
          onPressed: () => isShow
              ? viewmodel.showCreateUserDialog(context: context, isEdit: true)
              : null,
        ),
      ],
      child: viewmodel.state is UserListStateSuccess
          ? viewmodel.userList!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kWPaddingSmallSize,
                    vertical: kWPaddingMiniSize,
                  ),
                  child: UserInfoContent(
                    user: isShow
                        ? viewmodel.userList![viewmodel.selectedIndex]
                        : UserInfo(
                            circle_circle_name: "",
                            major_major_name: "",
                            member_member_srl: "",
                            member_permission: "",
                            member_phone_number: "",
                            member_user_name: "",
                          ),
                    isShow: isShow,
                  ),
                )
              : Container()
          : viewmodel.state is UserListStateError
              ? const Center(
                  child: Text("에러가 발생했습니다"),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
    );
  }
}
