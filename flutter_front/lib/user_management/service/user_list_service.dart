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
    await Future.delayed(const Duration(seconds: 1));
    try {
      // final resp = await repository.getUserList();
      final resp = List.generate(
        10,
        (index) => UserInfo(
          authority: "관리자",
          id: index % 2 == 0 ? "20200284" : "20191203",
          major: "컴퓨터소프트웨어공학과",
          name: index % 2 == 0 ? "김정현" : "최혜민",
          nickName: index % 2 == 0
              ? "sadknadslnadsnlkasdnlasdnkladslknasdklnd"
              : "바보",
        ),
      );
      state = UserListStateSuccess(resp);
    } on DioException {
      state = UserListStateError("서버에서 사용자 목록을 불러 올 수 없습니다.");
    } catch (e) {
      state = UserListStateError("알 수 없는 에러가 발생했습니다.");
    }
  }
}
