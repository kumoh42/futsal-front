import 'package:flutter_front/common/state/state.dart';
import 'package:flutter_front/reservation_status/model/entity/pre_reservation_status_entity.dart';

abstract class PreReservationSettingState {}

class PreReservaitonSettingStateNone extends NoneState
    implements PreReservationSettingState {}

class PreReservaitonSettingStateLoading extends LoadingState
    implements PreReservationSettingState {}

class PreReservationSettingStateSuccess extends SuccessState
    implements PreReservationSettingState {
  PreReservationSettingStateSuccess(super.data);
}

class PreReservationSettingStateError extends ErrorState
    implements PreReservationSettingState {
  PreReservationSettingStateError(super.message);
}

class PreReservationSettingListStateLoading extends LoadingState
    implements PreReservationSettingState {}

class PreReservationSettingListStateSuccess
    extends SuccessState<List<PreReservationStatusEntity>>
    implements PreReservationSettingState {
  PreReservationSettingListStateSuccess(super.data);
}
