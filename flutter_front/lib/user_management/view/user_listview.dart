import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/container/responsive_container.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/user_management/common/info_list.dart';
import 'package:flutter_front/user_management/model/entity/user_info_entity.dart';
import 'package:flutter_front/user_management/model/state/user_list_state.dart';
import 'package:flutter_front/user_management/viewmodel/user_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserListView extends ConsumerStatefulWidget {
  const UserListView({super.key});

  @override
  ConsumerState<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends ConsumerState<UserListView> {
  @override
  void initState() {
    super.initState();
    if (ref.read(userListViewmodelProvider.notifier).state
        is! UserListStateSuccess) {
      Future(
        () => ref.read(userListViewmodelProvider.notifier).getUserList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(userListViewmodelProvider);
    switch (viewmodel.state.runtimeType) {
      case UserListStateSuccess:
        return viewmodel.userList!.isNotEmpty
            ? viewmodel.searchPermission == authListForSearch[0]
                ? ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return userListItemContainer(
                        userInfo: viewmodel.userList![index],
                        onTap: () => viewmodel.selectedItem(index),
                        isSelected: viewmodel.selectedIndex == index,
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: kWPaddingMiniSize,
                    ),
                    itemCount: viewmodel.userList!.length,
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (viewmodel.userList![index].member_permission ==
                          viewmodel.searchPermission) {
                        return userListItemContainer(
                          userInfo: viewmodel.userList![index],
                          onTap: () => viewmodel.selectedItem(index),
                          isSelected: viewmodel.selectedIndex == index,
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: kWPaddingMiniSize,
                        ),
                    itemCount: viewmodel.userList!.length)
            : Center(
                child: Text(
                  "사용자가 없습니다",
                  style: kTextMainStyle.copyWith(
                    fontSize: kTextTitleSize,
                  ),
                ),
              );
      case UserListStateLoading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case UserListStateError:
        return const Center(
          child: Text("에러가 발생했습니다"),
        );
    }
    return Container();
  }
}

Widget userListItemContainer({
  required UserInfo userInfo,
  required VoidCallback onTap,
  bool isSelected = false,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(
        vertical: kWPaddingMiniSize,
        horizontal: kWPaddingSmallSize,
      ),
      decoration: BoxDecoration(
        color: isSelected ? kMainColor : kBackgroundMainColor,
        borderRadius: BorderRadius.circular(kBorderRadiusSize),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          renderInfoContainer(
              info: userInfo.member_member_srl, isSelected: isSelected),
          renderInfoContainer(
              info: userInfo.member_user_name, isSelected: isSelected),
          renderInfoContainer(
              info: userInfo.circle_circle_name, isSelected: isSelected),
          renderInfoContainer(
              info: userInfo.major_major_name, isSelected: isSelected),
          renderInfoContainer(
              info: userInfo.member_permission, isSelected: isSelected),
          Icon(
            Icons.keyboard_arrow_right_outlined,
            size: kIconMiddleSize,
            color: isSelected ? kBackgroundMainColor : kTextMainColor,
          ),
        ],
      ),
    ),
  );
}

Widget renderInfoContainer({
  required String info,
  bool isSelected = false,
}) {
  return Expanded(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              info,
              overflow: TextOverflow.ellipsis,
              style: kTextNormalStyle.copyWith(
                fontSize: kTextMiddleSize,
                color: isSelected ? kBackgroundMainColor : kTextMainColor,
              ),
            ),
          ),
        ),
        ResponsiveSizedBox(size: kPaddingMiddleSize),
      ],
    ),
  );
}
