import 'package:flutter_front/common/state/state.dart';
import 'package:flutter_front/user_management/model/entity/user_info_entity.dart';

abstract class UserListState {}

class UserListStateNone extends NoneState implements UserListState {}

class UserListStateLoading extends LoadingState implements UserListState {}

class UserListStateSuccess extends SuccessState<List<UserInfo>>
    implements UserListState {
  UserListStateSuccess(super.data);
}

class UserListStateError extends ErrorState implements UserListState {
  UserListStateError(super.message);
}
