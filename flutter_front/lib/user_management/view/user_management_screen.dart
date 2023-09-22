import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/container/designed_container.dart';
import 'package:flutter_front/common/component/container/responsive_container.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/user_management/view/search_row_view.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      children: [
        ResponsiveWidget(
          wFlex: 8,
          child: DesignedContainer(
            title: "사용자 목록",
            actions: [
              IconButton(
                splashRadius: kWIconSmallSize,
                icon: Icon(
                  Icons.add,
                  size: kIconMiddleSize,
                  weight: 100,
                ),
                onPressed: () {
                  print("hi!");
                },
              ),
            ],
            child: const Column(
              children: [
                SearchRowView(),
              ],
            ),
          ),
        ),
        ResponsiveSizedBox(size: kLayoutGutterSize),
        const ResponsiveWidget(
          wFlex: 4,
          child: DesignedContainer(
            title: "사용자 정보",
            child: Column(
              children: [
                Text("hi"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
