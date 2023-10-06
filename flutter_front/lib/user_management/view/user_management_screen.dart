import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/container/designed_container.dart';
import 'package:flutter_front/common/component/container/responsive_container.dart';
import 'package:flutter_front/common/component/custom_icon_button.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/user_management/common/info_list.dart';
import 'package:flutter_front/user_management/view/search_row_view.dart';
import 'package:flutter_front/user_management/view/user_info_container.dart';
import 'package:flutter_front/user_management/view/user_listview.dart';
import 'package:flutter_front/user_management/viewmodel/user_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserManagementScreen extends ConsumerWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = kTextMainStyle.copyWith(
      fontSize: kTextMiddleSize,
      fontWeight: FontWeight.w600,
    );
    final viewmodel = ref.watch(userListViewmodelProvider);
    return ResponsiveContainer(
      children: [
        ResponsiveWidget(
          wFlex: 8,
          mFlex: 3,
          child: DesignedContainer(
            title: "사용자 목록",
            isChildInfinity: true,
            actions: [
              CustomIconButton(
                icon: Icons.list,
                onPressed: () => viewmodel.showAwaitingList(context: context),
                hintMessage: "승인 대기 명단",
              )
            ],
            child: Column(
              children: [
                const SearchRowView(),
                ResponsiveSizedBox(
                  size: kPaddingMiddleSize,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kPaddingLargeSize),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(info[0], style: textStyle)),
                      Expanded(child: Text(info[1], style: textStyle)),
                      Expanded(child: Text(info[2], style: textStyle)),
                      Expanded(child: Text(info[3], style: textStyle)),
                      Expanded(child: Text(info[4], style: textStyle)),
                      ResponsiveSizedBox(size: kIconMiddleSize),
                    ],
                  ),
                ),
                ResponsiveSizedBox(
                  size: kPaddingMiddleSize,
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: kPaddingLargeSize),
                    child: const UserListView(),
                  ),
                ),
              ],
            ),
          ),
        ),
        ResponsiveSizedBox(size: kLayoutGutterSize),
        const ResponsiveWidget(
          wFlex: 4,
          mFlex: 1,
          child: UserInfoContainer(),
        ),
      ],
    );
  }
}
