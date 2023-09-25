import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/user_management/common/dialog/user_info_edit_dialog.dart';
import 'package:flutter_front/user_management/model/entity/user_info_entity.dart';
import 'package:flutter_front/user_management/model/state/user_list_state.dart';
import 'package:flutter_front/user_management/service/user_list_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userListViewmodelProvider =
    ChangeNotifierProvider((ref) => UserListViewModel(ref));

class UserListViewModel extends ChangeNotifier {
  late int selectedIndex;
  final Ref ref;
  late UserListState state;
  UserListViewModel(this.ref) {
    selectedIndex = 0;
    state = ref.watch(userListServiceProvider);
  }
  List<UserInfo>? get userList => state is UserListStateSuccess
      ? (state as UserListStateSuccess).data
      : null;

  void getUserList() async {
    await ref.read(userListServiceProvider.notifier).getUserList();
  }

  void selectedItem(int index) {
    selectedIndex = index;

    notifyListeners();
  }

  void showUserInfoEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const UserInfoEditDialog();
      },
    );
  }

  Future<bool> removeUser(BuildContext context) async {
    bool isRemove = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '삭제 확인',
            style: kTextMainStyle.copyWith(fontSize: kTextMiddleSize),
          ),
          content: Text(
            '정말 삭제하시겠습니까?',
            style: kTextNormalStyle.copyWith(fontSize: kTextMiddleSize),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                isRemove = true;
                await ref.read(userListServiceProvider.notifier).removeUser();
                Navigator.of(context).pop();
              },
              child: Text(
                '예',
                style: kTextMainStyle.copyWith(fontSize: kTextSmallSize),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                '아니요',
                style: kTextMainStyle.copyWith(fontSize: kTextSmallSize),
              ),
            ),
          ],
        );
      },
    );
    return isRemove;
  }

  void editUser(BuildContext context) async {
    await ref.read(userListServiceProvider.notifier).editUser();
  }
}
