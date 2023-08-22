import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/reservation_status/component/custom_container.dart';

class PreReservationSettingStatusView extends StatelessWidget {
  const PreReservationSettingStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      title: "우선예약 설정 현황",
      height: 250,
      child: ListView.separated(
          itemBuilder: (context, index) => const Row(
                children: [
                  Text(
                    "2023년 6월 28일 20:00:00",
                    style: kTextNormalStyleLarge,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.close,
                    color: Colors.red,
                  )
                ],
              ),
          separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
          itemCount: 31),
    );
  }
}
