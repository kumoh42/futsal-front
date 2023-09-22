import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/container/responsive_container.dart';
import 'package:flutter_front/common/component/custom_dropdown_menu.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/common/styles/sizes.dart';

class SearchRowView extends StatelessWidget {
  const SearchRowView({super.key});

  @override
  Widget build(BuildContext context) {
    final authorityController = CustomDropDownMenuController(
      menuList: ["일반", "관리자", "사용자"],
    );
    final departmentController = CustomDropDownMenuController(
      menuList: ["컴퓨터공학과", "컴퓨터소프트웨어공학과", "전자공학과"],
    );
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: kBackgroundMainColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: kBorderColor,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: kShadowColor,
                    blurRadius: 4,
                    offset: Offset(0, 4), // Shadow position
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: kPaddingMiddleSize,
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.only(
                      right: kPaddingMiddleSize,
                    ),
                    splashRadius: 1,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ResponsiveSizedBox(size: kPaddingLargeSize),
          Expanded(
            flex: 1,
            child: CustomDropDownMenu(
              title: "권한",
              controller: authorityController,
              titleSize: kWTextSuperMiniSize,
            ),
          ),
          ResponsiveSizedBox(size: kPaddingMiddleSize),
          Expanded(
            flex: 2,
            child: CustomDropDownMenu(
              title: "소속",
              controller: departmentController,
              titleSize: kWTextSuperMiniSize,
            ),
          ),
        ],
      ),
    );
  }
}
