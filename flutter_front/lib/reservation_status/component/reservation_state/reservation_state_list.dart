import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/reservation_status/component/reservation_state/reservation_state_item.dart';
import 'package:flutter_front/reservation_status/model/entity/reservation_entity.dart';
import 'package:flutter_front/reservation_status/model/state/reservation_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationStateList extends ConsumerStatefulWidget {
  final ReservationStatusListState state;
  final List<ReservationStatusEntity>? reservationStatusList;
  final double height;
  late final ChangeNotifierProvider<CustomCancelListController> provider;
  ReservationStateList({
    Key? key,
    required this.state,
    required this.reservationStatusList,
    required this.height,
    required CustomCancelListController controller,
  }) : super(key: key) {
    provider = ChangeNotifierProvider((ref) => controller);
  }

  @override
  ConsumerState<ReservationStateList> createState() =>
      _ReservationStateListState();
}

class _ReservationStateListState extends ConsumerState<ReservationStateList> {
  late CustomCancelListController controller;

  @override
  Widget build(BuildContext context) {
    controller = ref.watch(widget.provider);

    switch (widget.state.runtimeType) {
      case ReservationStatusListStateNone:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage("assets/image/black_logo.png"),
                width: widget.height * 3 / 7,
                height: widget.height * 3 / 7,
              ),
              Text(
                "아직 예약이 오픈되지 않았습니다.",
                style: kTextMainStyleMiddle,
              ),
              SizedBox(height: kPaddingMiddleSize),
            ],
          ),
        );
      case ReservationStatusListStateLoading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case ReservationStatusListStateSuccess:
        return ListView.builder(
          shrinkWrap: true,
          itemCount: widget.reservationStatusList!.length,
          itemBuilder: (context, i) => ReservationStateItem(
            index: i,
            height: (widget.height / widget.reservationStatusList!.length -
                    kBorderSideWidth)
                .floorToDouble(),
            entity: widget.reservationStatusList![i],
            isChecked: controller
                .isChecked(widget.reservationStatusList![i].reservationId),
            onPressed: (value) {
              controller.clickedCheckBox(
                  widget.reservationStatusList![i].reservationId);
            },
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
