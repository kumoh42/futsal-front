import 'package:flutter/material.dart';
import 'package:flutter_front/reservation_status/component/pre_reservation_status_row.dart';
import 'package:flutter_front/reservation_status/model/entity/pre_reservation/pre_reservation_status_entity.dart';
import 'package:flutter_front/reservation_status/model/state/pre_reservation/pre_reservation_setting_state.dart';

class PreReservationStatusList extends StatelessWidget {
  final List<PreReservationStatusEntity>? list;
  final PreReservationSettingState state;
  final void Function(PreReservationStatusEntity)? onCancelClicked;

  const PreReservationStatusList({
    super.key,
    required this.list,
    required this.state,
    required this.onCancelClicked,
  });

  @override
  Widget build(BuildContext context) {
    switch (state.runtimeType) {
      case PreReservationSettingListStateLoading:
        return const Center(child: CircularProgressIndicator());

      case PreReservationSettingListStateSuccess:
        return ListView.separated(
          itemBuilder: (context, index) => PreReservationStatusRow(
            entity: list![index],
            onCancelClicked: onCancelClicked,
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemCount: list!.length,
        );
    }
    return Container();
  }
}
