import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/container/responsive_container.dart';
import 'package:flutter_front/common/component/custome_titled_text.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/user_management/common/info_list.dart';
import 'package:flutter_front/user_management/model/entity/user_info_entity.dart';

class UserInfoContent extends StatelessWidget {
  final bool isShow;
  final UserInfo user;
  const UserInfoContent({
    super.key,
    required this.user,
    this.isShow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isShow)
          CustomTitledText(
            title: info[0],
            content: Text(
              user.member_member_srl,
              style: kTextNormalStyle.copyWith(
                fontSize: kTextMiddleSize,
              ),
            ),
          ),
        ResponsiveSizedBox(size: kPaddingMiddleSize),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (isShow)
              Expanded(
                child: CustomTitledText(
                  title: info[1],
                  content: Text(
                    user.member_user_name,
                    style: kTextNormalStyle.copyWith(
                      fontSize: kTextMiddleSize,
                    ),
                  ),
                ),
              ),
            ResponsiveSizedBox(size: kPaddingMiddleSize),
            if (isShow)
              Expanded(
                child: CustomTitledText(
                  title: info[4],
                  content: Text(
                    user.member_phone_number,
                    style: kTextNormalStyle.copyWith(
                      fontSize: kTextMiddleSize,
                    ),
                  ),
                ),
              ),
            const SizedBox(),
          ],
        ),
        ResponsiveSizedBox(size: kPaddingMiddleSize),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (isShow)
              Expanded(
                child: CustomTitledText(
                  title: info[2],
                  content: Text(
                    user.circle_circle_name,
                    style: kTextNormalStyle.copyWith(
                      fontSize: kTextMiddleSize,
                    ),
                  ),
                ),
              ),
            ResponsiveSizedBox(size: kPaddingMiddleSize),
            if (isShow)
              Expanded(
                child: CustomTitledText(
                  title: info[3],
                  content: Text(
                    user.major_major_name,
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
    );
  }
}
