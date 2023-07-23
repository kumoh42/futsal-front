import 'package:flutter_front/common/state/state.dart';
import 'package:flutter_front/user/model/entity/login_response_entity.dart';

abstract class AuthState {}

class AuthStateNone extends NoneState implements AuthState {}

class AuthStateLoading extends LoadingState implements AuthState {}

class AuthStateSuccess extends SuccessState<LoginResponseEntity> implements AuthState {
  AuthStateSuccess(super.data);
}

class AuthStateError extends ErrorState implements AuthState {
  AuthStateError(super.message);
}
