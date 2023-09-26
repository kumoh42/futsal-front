import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/container/responsive_container.dart';
import 'package:flutter_front/common/component/custom_dropdown_menu.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/user_management/common/info_list.dart';
import 'package:flutter_front/user_management/viewmodel/user_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchRowView extends ConsumerWidget {
  const SearchRowView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authorityController =
        CustomDropDownMenuController(menuList: authListForSearch);
    authorityController.addListener(() {
      ref
          .read(userListViewmodelProvider)
          .selectedSearchPermission(authorityController.selected);
    });

    final departmentController =
        CustomDropDownMenuController(menuList: majorList);

    return !ResponsiveData.kIsMobile
        ? IntrinsicHeight(
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
                          offset: Offset(0, 4),
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
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'search',
                                hintStyle: kTextDisabledStyle.copyWith(
                                  fontSize: kTextMiddleSize,
                                  fontWeight: FontWeight.w400,
                                ),
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
                    titleTextStyle: kTextDisabledStyle.copyWith(
                      fontSize: kTextMiniSize,
                      fontWeight: FontWeight.w400,
                      color: kTextMainColor,
                    ),
                  ),
                ),
                ResponsiveSizedBox(size: kPaddingMiddleSize),
                Expanded(
                  flex: 2,
                  child: CustomDropDownMenu(
                    title: "소속",
                    controller: departmentController,
                    titleTextStyle: kTextDisabledStyle.copyWith(
                      fontSize: kTextMiniSize,
                      fontWeight: FontWeight.w400,
                      color: kTextMainColor,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: kPaddingSmallSize),
            child: Column(
              children: [
                Container(
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
                        offset: Offset(0, 4),
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
                          child: TextField(
                            style: TextStyle(fontSize: kTextMiddleSize),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'search',
                              hintStyle: kTextDisabledStyle.copyWith(
                                fontSize: kTextMiddleSize,
                                fontWeight: FontWeight.w400,
                              ),
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
                        icon: Icon(
                          Icons.search,
                          size: kIconMiddleSize,
                        ),
                      ),
                    ],
                  ),
                ),
                ResponsiveSizedBox(size: kPaddingLargeSize),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomDropDownMenu(
                        title: "권한",
                        controller: authorityController,
                        titleTextStyle: kTextDisabledStyle.copyWith(
                          fontSize: kTextMiniSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ResponsiveSizedBox(size: kPaddingMiddleSize),
                    Expanded(
                      flex: 2,
                      child: CustomDropDownMenu(
                        title: "소속",
                        controller: departmentController,
                        titleTextStyle: kTextDisabledStyle.copyWith(
                          fontSize: kTextMiniSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
