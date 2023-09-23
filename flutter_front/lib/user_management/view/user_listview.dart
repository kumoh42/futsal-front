import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/user_management/viewmodel/user_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserListView extends ConsumerWidget {
  const UserListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(userListViewmodelProvider);
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return userListItemContainer(
          item: viewmodel.userList[index],
          onTap: () => viewmodel.selectedItem(index),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: kWPaddingMiniSize,
      ),
      itemCount: 100,
    );
  }
}

Widget userListItemContainer({
  required UserListItemWithIsSelected item,
  required VoidCallback onTap,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(kBorderRadiusSize),
    customBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kBorderRadiusSize),
    ),
    hoverColor: kMainColor,
    splashColor: kMainColor,
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(
        vertical: kWPaddingMiniSize,
        horizontal: kWPaddingSmallSize,
      ),
      decoration: BoxDecoration(
        color: item.isSelected ? kMainColor : kBackgroundMainColor,
        borderRadius: BorderRadius.circular(kBorderRadiusSize),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...List.generate(
            5,
            (i) => Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  item.info[i],
                  overflow: TextOverflow.ellipsis,
                  style: kTextNormalStyle.copyWith(
                    fontSize: kTextMiddleSize,
                    color:
                        item.isSelected ? kBackgroundMainColor : kTextMainColor,
                  ),
                ),
              ),
            ),
          ).toList(),
          Icon(
            Icons.keyboard_arrow_right_outlined,
            size: kIconMiddleSize,
            color: item.isSelected ? kBackgroundMainColor : kTextMainColor,
          ),
        ],
      ),
    ),
  );
}
