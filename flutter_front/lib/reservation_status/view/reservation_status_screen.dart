import 'package:flutter/material.dart';
import 'package:flutter_front/common/layout/default_layout.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/reservation_status/component/custom_container.dart';
import 'package:flutter_front/reservation_status/view/reservation_status_view.dart';

class ReservationStatusScreen extends StatelessWidget {
  const ReservationStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        return DefaultLayout(
          child: SingleChildScrollView(
            child: CustomContainer(
              width: width,
              minHeight: height,
              color: CustomColor.disabledColor,
              child: const Wrap(
                direction: Axis.horizontal,
                children: [
                  ReservationStatusView(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
