import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/user_management/common/dialog/user_create_dialog.dart';
import 'package:flutter_front/user_management/common/dialog/user_info_edit_dialog.dart';
import 'package:flutter_front/user_management/common/info_list.dart';
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
  late String searchPermission;
  UserListViewModel(this.ref) {
    selectedIndex = -1;
    state = ref.watch(userListServiceProvider);
    searchPermission = authListForSearch[0];
  }
  List<UserInfo>? get userList => state is UserListStateSuccess
      ? (state as UserListStateSuccess).data
      : null;

  void getUserList() async {
    await ref.read(userListServiceProvider.notifier).getUserList();
  }

  void selectedItem(int index) {
    if (selectedIndex == index) {
      selectedIndex = -1;
    } else {
      selectedIndex = index;
    }

    notifyListeners();
  }

  void selectedSearchPermission(String permission) {
    searchPermission = permission;

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

  void showCreateUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return UserCreateDialog(
          onPressed: (user) async {
            await ref.read(userListServiceProvider.notifier).createUser(user);
          },
        );
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
                await ref
                    .read(userListServiceProvider.notifier)
                    .removeUser(userList![selectedIndex].member_member_srl);
                selectedIndex--;
                if (context.mounted) Navigator.of(context).pop();
              },
              child: Text(
                '예',
                style: kTextMainStyle.copyWith(fontSize: kTextSmallSize),
              ),
            ),
            TextButton(
              onPressed: () {
                if (context.mounted) Navigator.of(context).pop();
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

  void editUser(BuildContext context, UserInfo user) async {
    await ref.read(userListServiceProvider.notifier).editUser(user);
  }
}
