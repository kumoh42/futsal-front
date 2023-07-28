import 'package:flutter/material.dart';
import 'package:flutter_front/auth/model/entity/user_entity.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/reservation_status/component/custom_container.dart';

class ProfileItem extends StatelessWidget {
  final UserEntity entity;
  final Function() logout;

  const ProfileItem({
    Key? key,
    required this.entity,
    required this.logout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      isBackground: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: kPaddingSmallSize),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: CustomColor.disabledColor,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(kPaddingSmallSize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entity.name, style: kTextMainStyleMiddle),
                  const SizedBox(height: kPaddingSmallSize),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(child: Text('관리자', style: kTextMainStyleSmall)),
                      const SizedBox(width: kPaddingSmallSize),
                      ElevatedButton(
                        onPressed: logout,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColor.mainColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(kBorderRadiusSize),
                            ),
                          ),
                        ),
                        child: Text(
                          "Logout",
                          style: kTextMainStyleSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
