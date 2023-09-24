import 'package:flutter/material.dart';
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
        return UserInfoEditDialog();
      },
    );
  }
}

// class UserListItemWithIsSelected {
//   final UserInfo userInfo;
//   bool isSelected;
//   UserListItemWithIsSelected({
//     required this.userInfo,
//     required this.isSelected,
//   });
// }
