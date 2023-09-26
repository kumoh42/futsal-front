import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/container/designed_container.dart';
import 'package:flutter_front/common/component/custome_titled_text.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/user_management/common/info_list.dart';
import 'package:flutter_front/user_management/model/state/user_list_state.dart';
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
        IconButton(
          onPressed: () =>
              isShow ? viewmodel.showUserInfoEditDialog(context) : null,
          icon: Icon(Icons.edit, size: kIconMiddleSize),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          splashRadius: kIconMiddleSize / 1.2,
        ),
      ],
      child: viewmodel.state is UserListStateSuccess
          ? viewmodel.userList!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kWPaddingSmallSize,
                    vertical: kWPaddingMiniSize,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isShow)
                        CustomTitledText(
                          title: info[0],
                          content: Text(
                            viewmodel.userList![viewmodel.selectedIndex]
                                .member_member_srl,
                            style: kTextNormalStyle.copyWith(
                              fontSize: kTextMiddleSize,
                            ),
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (isShow)
                            Expanded(
                              child: CustomTitledText(
                                title: info[1],
                                content: Text(
                                  viewmodel.userList![viewmodel.selectedIndex]
                                      .member_user_name,
                                  style: kTextNormalStyle.copyWith(
                                    fontSize: kTextMiddleSize,
                                  ),
                                ),
                              ),
                            ),
                          if (isShow)
                            Expanded(
                              child: CustomTitledText(
                                title: info[4],
                                content: Text(
                                  viewmodel.userList![viewmodel.selectedIndex]
                                      .member_permission,
                                  style: kTextNormalStyle.copyWith(
                                    fontSize: kTextMiddleSize,
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (isShow)
                            Expanded(
                              child: CustomTitledText(
                                title: info[2],
                                content: Text(
                                  viewmodel.userList![viewmodel.selectedIndex]
                                      .circle_circle_name,
                                  style: kTextNormalStyle.copyWith(
                                    fontSize: kTextMiddleSize,
                                  ),
                                ),
                              ),
                            ),
                          if (isShow)
                            Expanded(
                              child: CustomTitledText(
                                title: info[3],
                                content: Text(
                                  viewmodel.userList![viewmodel.selectedIndex]
                                      .major_major_name,
                                  style: kTextNormalStyle.copyWith(
                                    fontSize: kTextMiddleSize,
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(),
                        ],
                      ),
                    ],
                  ),
                )
              : Container()
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
