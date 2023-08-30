import 'package:flutter_front/common/state/state.dart';

abstract class ProgressReservationState {}

class ProgressReservationStateNone extends NoneState
    implements ProgressReservationState {}

class ProgressReservationStateLoading extends LoadingState
    implements ProgressReservationState {}

class ProgressReservationStateSuccess extends SuccessState
    implements ProgressReservationState {
  ProgressReservationStateSuccess(super.data, {super.message});
}

class ProgressReservationStateError extends ErrorState
    implements ProgressReservationState {
  ProgressReservationStateError(super.message);
}
