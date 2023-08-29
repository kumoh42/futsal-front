import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/reservation_status/component/reservation_state/reservation_state_item.dart';
import 'package:flutter_front/reservation_status/model/entity/reservation_entity.dart';
import 'package:flutter_front/reservation_status/model/state/reservation_list_state.dart';

class ReservationStateList extends StatelessWidget {
  final ReservationStatusListState state;
  final List<ReservationStatusEntity>? reservationStatusList;
  final double height;
  final CustomCancelListController customCancelListController;

  const ReservationStateList({
    Key? key,
    required this.state,
    required this.reservationStatusList,
    required this.height,
    required this.customCancelListController,
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
            height: (height / reservationStatusList!.length - kBorderSideWidth)
                .floorToDouble(),
            entity: reservationStatusList![i],
            controller: customCancelListController,
          ),
        );
      case ReservationStatusListStateError:
        return Container();
    }
    return Container();
  }
}

class CustomCancelListController extends ChangeNotifier {
  late final List<int> _cancelIdList;
  CustomCancelListController() {
    _cancelIdList = [];
  }

  List<int> get cancelIdList => _cancelIdList;

  void clickedCheckBox(int id) {
    if (isChecked(id)) {
      _cancelIdList.remove(id);
    } else {
      _cancelIdList.add(id);
      _cancelIdList.sort();
    }
    notifyListeners();
  }

  void reset() {
    _cancelIdList.clear();
    notifyListeners();
  }

  bool isChecked(int id) {
    return _cancelIdList.contains(id);
  }
}
