import 'package:flutter/material.dart';
import 'package:flutter_front/reservation_status/component/custom_container.dart';

class ProgressReservation extends StatelessWidget {
  const ProgressReservation({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomContainer(
      title: "진행 중인 예약",
      height: 250,
      child: Column(
        children: [
          Text(
            "2023년 5월 28일\n20:00:00",
          ),
        ],
      ),
    );
  }
}
