import 'package:dio/dio.dart';
import 'package:flutter_front/user_management/model/repository/user_list_repository.dart';
import 'package:flutter_front/user_management/model/state/wating_user_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final watingUserListServiceProvider =
    StateNotifierProvider<WatingUserListService, WatingUserListState>((ref) {
  final repo = ref.watch(userListRepositoryProvider);
  return WatingUserListService(repo);
});

class WatingUserListService extends StateNotifier<WatingUserListState> {
  final UserListRepository repository;
  WatingUserListService(this.repository) : super(WatingUserListStateNone());

  Future getAwaitingUserList() async {
    try {
      state = WatingUserListStateLoading();
      final resp = await repository.getAwaitingUserList();

      state = WatingUserListStateSuccess(resp);
    } on DioException {
      state = WatingUserListStateError("서버에서 사용자 목록을 불러 올 수 없습니다.");
    } catch (e) {
      state = WatingUserListStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future removeUser(String id) async {
    try {
      await repository.removeUser(id);
      await getAwaitingUserList();
    } on DioException {
      state = WatingUserListStateError("서버와의 통신이 끊겼습니다.");
    } catch (e) {
      state = WatingUserListStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future approveUser(String id) async {
    try {
      await repository.approveUser(id);
      await getAwaitingUserList();
    } on DioException {
      state = WatingUserListStateError("서버와의 통신이 끊겼습니다.");
    } catch (e) {
      state = WatingUserListStateError("알 수 없는 에러가 발생했습니다.");
    }
  }
}
