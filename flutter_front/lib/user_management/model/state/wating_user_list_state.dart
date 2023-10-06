import 'package:flutter_front/common/state/state.dart';
import 'package:flutter_front/user_management/model/entity/user_info_entity.dart';

abstract class WatingUserListState {}

class WatingUserListStateNone extends NoneState
    implements WatingUserListState {}

class WatingUserListStateLoading extends LoadingState
    implements WatingUserListState {}

class WatingUserListStateSuccess extends SuccessState<List<UserInfo>>
    implements WatingUserListState {
  WatingUserListStateSuccess(super.data);
}

class WatingUserListStateError extends ErrorState
    implements WatingUserListState {
  WatingUserListStateError(super.message);
}
