import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/reservation_status/component/reservation_state/reservation_state_item.dart';
import 'package:flutter_front/reservation_status/model/entity/reservation_entity.dart';
import 'package:flutter_front/reservation_status/model/state/reservation_list_state.dart';

class ReservationStateList extends StatelessWidget {
  final ReservationStatusListState state;
  final List<ReservationStatusEntity>? reservationStatusList;
  final double height;
  final void Function(ReservationStatusEntity)? onCancelClicked;

  const ReservationStateList({
    Key? key,
    required this.state,
    required this.reservationStatusList,
    required this.onCancelClicked,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (state.runtimeType) {
      case ReservationStatusListStateNone:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage("assets/image/black_logo.png"),
                width: height * 3 / 7,
                height: height * 3 / 7,
              ),
              const Text(
                "아직 예약이 오픈되지 않았습니다.",
                style: kTextMainStyleMiddle,
              ),
              const SizedBox(height: kPaddingMiddleSize),
            ],
          ),
        );
      case ReservationStatusListStateLoading:
        return const Center(child: CircularProgressIndicator());
      case ReservationStatusListStateSuccess:
        return ListView.builder(
          shrinkWrap: true,
          itemCount: reservationStatusList!.length,
          itemBuilder: (context, i) => ReservationStateItem(
            height: (height / reservationStatusList!.length - 0.5).floorToDouble(),
            entity: reservationStatusList![i],
            onCancelClicked: onCancelClicked,
          ),
        );
      case ReservationStatusListStateError:
        return Container();
    }
    return Container();
  }
}