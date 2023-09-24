import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/container/designed_container.dart';
import 'package:flutter_front/common/component/custome_titled_text.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/user_management/model/state/user_list_state.dart';
import 'package:flutter_front/user_management/viewmodel/user_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfoContainer extends ConsumerWidget {
  const UserInfoContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(userListViewmodelProvider);
    return DesignedContainer(
      title: "사용자 정보",
      actions: [
        IconButton(
          onPressed: () => viewmodel.state is UserListStateSuccess
              ? viewmodel.showUserInfoEditDialog(context)
              : null,
          icon: Icon(Icons.edit, size: kIconMiddleSize),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          splashRadius: kIconMiddleSize / 1.2,
        ),
      ],
      child: viewmodel.state is UserListStateSuccess
          ? Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kWPaddingSmallSize,
                vertical: kWPaddingMiniSize,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTitledText(
                    title: "아이디",
                    content: viewmodel.userList![viewmodel.selectedIndex].id,
                  ),
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
                      Expanded(
                        child: CustomTitledText(
                          title: "권한",
                          content: viewmodel
                              .userList![viewmodel.selectedIndex].authority,
                        ),
                      ),
                      const SizedBox(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomTitledText(
                          title: "닉네임  ",
                          content: viewmodel
                              .userList![viewmodel.selectedIndex].nickName,
                        ),
                      ),
                      Expanded(
                        child: CustomTitledText(
                          title: "소속",
                          content: viewmodel
                              .userList![viewmodel.selectedIndex].major,
                        ),
                      ),
                      const SizedBox(),
                    ],
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
