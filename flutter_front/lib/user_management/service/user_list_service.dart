import 'package:dio/dio.dart';
import 'package:flutter_front/user_management/model/entity/user_edit_entity.dart';
import 'package:flutter_front/user_management/model/entity/user_info_entity.dart';
import 'package:flutter_front/user_management/model/repository/user_list_repository.dart';
import 'package:flutter_front/user_management/model/state/user_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userListServiceProvider =
    StateNotifierProvider<UserListService, UserListState>((ref) {
  final repo = ref.watch(userListRepositoryProvider);
  return UserListService(repo);
});

class UserListService extends StateNotifier<UserListState> {
  final UserListRepository repository;
  UserListService(this.repository) : super(UserListStateNone());

  Future getUserList() async {
    state = UserListStateLoading();

    try {
      final resp = await repository.getUserList();
      state = UserListStateSuccess(resp);
    } on DioException {
      state = UserListStateError("서버에서 사용자 목록을 불러 올 수 없습니다.");
    } catch (e) {
      state = UserListStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future removeUser(String id) async {
    try {
      await repository.removeUser(id);
      await getUserList();
    } on DioException {
      state = UserListStateError("서버와의 통신이 끊겼습니다.");
    } catch (e) {
      state = UserListStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future editUser(String member_srl, UserEditEntity user) async {
    try {
      await repository.editUser(member_srl, user);
      await getUserList();
    } on DioException {
      state = UserListStateError("서버에서 사용자 목록을 불러 올 수 없습니다.");
    } catch (e) {
      state = UserListStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future createUser(UserInfo user) async {
    try {} on DioException {
      state = UserListStateError("서버에서 사용자 목록을 불러 올 수 없습니다.");
    } catch (e) {
      state = UserListStateError("알 수 없는 에러가 발생했습니다.");
    }
  }
}
