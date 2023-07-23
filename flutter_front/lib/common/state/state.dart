abstract class NoneState {}

abstract class LoadingState {}

abstract class SuccessState<T> {
  T data;
  SuccessState(this.data);
}

abstract class ErrorState {
  String message;
  ErrorState(this.message);
}