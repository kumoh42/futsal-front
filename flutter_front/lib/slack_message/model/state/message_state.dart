import 'package:flutter_front/common/state/state.dart';

abstract class MessageState {}

class MessageStateNone extends NoneState implements MessageState {}

class MessageStateLoading extends LoadingState implements MessageState {}

class MessageStateSuccess extends SuccessState implements MessageState {
  MessageStateSuccess(super.data);
}

class MessageStateError extends ErrorState implements MessageState {
  MessageStateError(super.message);
}
