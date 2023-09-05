import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/custom_elevated_button.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/reservation_status/component/custom_container.dart';

class ProgressReservationView extends StatelessWidget {
  ProgressReservationView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      title: "진행 중인 예약",
      height: !kIsMobile ? 250 : 150,
      child: !kIsMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "2023년 5월 28일\n20:00:00",
                  style: kTextNormalStyleLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: kPaddingSmallSize,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        CustomElevatedButton(
                          color: CustomColor.mainColor,
                          verticalPadding: 5,
                          horizontalPadding: 0,
                          content: Row(
                            children: [
                              const Icon(Icons.pause),
                              Text(
                                "예약중단",
                                style: kTextReverseStyleSmall,
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                        SizedBox(height: kPaddingMiddleSize),
                        CustomElevatedButton(
                          color: CustomColor.mainColor,
                          verticalPadding: 5,
                          horizontalPadding: 0,
                          content: Row(
                            children: [
                              const Icon(Icons.play_arrow),
                              Text(
                                "예약재개",
                                style: kTextReverseStyleSmall,
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(width: kPaddingMiddleSize),
                    CustomElevatedButton(
                      color: CustomColor.pointColor,
                      verticalPadding: 16,
                      horizontalPadding: 0,
                      content: Column(
                        children: [
                          const Icon(Icons.refresh_outlined),
                          Text(
                            "예약내역\n  초기화",
                            style: kTextReverseStyleSmall.copyWith(
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "2023년 5월 28일\n20:00:00",
                    style: kTextNormalStyleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: kPaddingSmallSize),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomElevatedButton(
                          color: CustomColor.mainColor,
                          verticalPadding: 5,
                          horizontalPadding: 0,
                          content: Row(
                            children: [
                              const Icon(Icons.pause),
                              Text(
                                "예약중단",
                                style: kTextReverseStyleSmall,
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                        SizedBox(height: kPaddingMiddleSize),
                        CustomElevatedButton(
                          color: CustomColor.mainColor,
                          verticalPadding: 5,
                          horizontalPadding: 0,
                          content: Row(
                            children: [
                              const Icon(Icons.play_arrow),
                              Text(
                                "예약재개",
                                style: kTextReverseStyleSmall,
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(width: kPaddingMiddleSize),
                    CustomElevatedButton(
                      color: CustomColor.pointColor,
                      verticalPadding: 16,
                      horizontalPadding: 0,
                      content: Column(
                        children: [
                          const Icon(Icons.refresh_outlined),
                          Text(
                            "예약내역\n초기화",
                            style: kTextReverseStyleSmall.copyWith(
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
