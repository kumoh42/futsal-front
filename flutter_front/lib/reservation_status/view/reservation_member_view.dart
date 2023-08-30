import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/reservation_status/component/custom_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationMemberView extends ConsumerWidget {
  const ReservationMemberView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final height = constraints.maxHeight;
      return CustomContainer(
        width: width,
        height: height,
        title: "사용자 조회",
        child: CustomContainer(
          color: CustomColor.backgroundMainColor,
          child: ListView.builder(itemCount: 3, itemBuilder: (context, index) => Container()),
        ),
      );
    });
  }
}
