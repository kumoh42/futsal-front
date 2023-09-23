import 'package:flutter/material.dart';
import 'package:flutter_front/user_management/model/state/user_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userListViewmodelProvider =
    ChangeNotifierProvider((ref) => UserListViewModel(ref));

class UserListViewModel extends ChangeNotifier {
  final userList = List.generate(
    100,
    (index) => UserListItemWithIsSelected(info: [
      index % 2 == 0 ? "20200284" : "20191203",
      "김정현",
      "헨리",
      "기계시스템공학과",
      "관리자"
    ], isSelected: false),
  );
  late int selectedIndex;
  final Ref ref;
  late UserListState state;
  UserListViewModel(this.ref) {
    selectedIndex = 0;
    userList[selectedIndex].isSelected = !userList[selectedIndex].isSelected;
    notifyListeners();
  }

  void selectedItem(int index) {
    userList[selectedIndex].isSelected = !userList[selectedIndex].isSelected;

    selectedIndex = index;
    userList[selectedIndex].isSelected = !userList[selectedIndex].isSelected;
    notifyListeners();
  }
}

class UserListItemWithIsSelected {
  final List<String> info;
  bool isSelected;
  UserListItemWithIsSelected({
    required this.info,
    required this.isSelected,
  });
}
