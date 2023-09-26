import 'package:dio/dio.dart';
import 'package:flutter_front/user_management/model/entity/user_info_entity.dart';
import 'package:flutter_front/user_management/model/repository/user_list_repository.dart';
import 'package:flutter_front/user_management/model/state/user_list_state.dart';
import 'package:flutter_front/user_management/viewmodel/user_list_viewmodel.dart';
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
      //   final resp = await repository.getUserList();
      final resp = List.generate(
        50,
        (index) => UserInfo(
          member_member_srl: index % 2 == 0 ? "12599" : "12333",
          member_user_name: "박준민",
          member_phone_number: "010-5240-5085",
          member_permission: index % 2 == 0 ? "user" : "admin",
          circle_circle_name: "아키",
          major_major_name: index % 2 == 0 ? "건축학부" : "컴퓨터공학과",
        ),
      );
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
    } on DioException {
      state = UserListStateError("서버와의 통신이 끊겼습니다.");
    } catch (e) {
      state = UserListStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future editUser(UserInfo user) async {
    await Future.delayed(const Duration(seconds: 1));
    try {} on DioException {
      state = UserListStateError("서버에서 사용자 목록을 불러 올 수 없습니다.");
    } catch (e) {
      state = UserListStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future createUser(UserInfo user) async {
    await Future.delayed(const Duration(seconds: 1));
    try {} on DioException {
      state = UserListStateError("서버에서 사용자 목록을 불러 올 수 없습니다.");
    } catch (e) {
      state = UserListStateError("알 수 없는 에러가 발생했습니다.");
    }
  }
}
