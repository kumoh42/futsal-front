import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/container/designed_container.dart';
import 'package:flutter_front/common/component/container/responsive_container.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/user_management/view/search_row_view.dart';
import 'package:flutter_front/user_management/view/user_info_container.dart';
import 'package:flutter_front/user_management/view/user_listview.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = kTextMainStyle.copyWith(
      fontSize: kTextMiddleSize,
      fontWeight: FontWeight.w600,
    );
    return ResponsiveContainer(
      children: [
        ResponsiveWidget(
          wFlex: 8,
          mFlex: 2,
          child: DesignedContainer(
            title: "사용자 목록",
            isChildInfinity: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add, size: kIconMiddleSize),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                splashRadius: kIconMiddleSize / 1.2,
              ),
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
                      Expanded(child: Text("ID", style: textStyle)),
                      Expanded(child: Text("이름", style: textStyle)),
                      Expanded(child: Text("닉네임", style: textStyle)),
                      Expanded(child: Text("소속", style: textStyle)),
                      Expanded(child: Text("권한", style: textStyle)),
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
