import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/container/responsive_container.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
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
        () => ref.read(userListViewmodelProvider).getUserList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(userListViewmodelProvider);
    return viewmodel.state is UserListStateSuccess
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
        : const Center(
            child: CircularProgressIndicator(),
          );
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
          renderInfoContainer(info: userInfo.id, isSelected: isSelected),
          renderInfoContainer(info: userInfo.name, isSelected: isSelected),
          renderInfoContainer(info: userInfo.nickName, isSelected: isSelected),
          renderInfoContainer(info: userInfo.major, isSelected: isSelected),
          renderInfoContainer(info: userInfo.authority, isSelected: isSelected),
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
