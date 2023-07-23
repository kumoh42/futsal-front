import 'package:flutter/material.dart';
import 'package:flutter_front/auth/model/service/auth_service.dart';
import 'package:flutter_front/auth/model/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginViewModelProvider =
    ChangeNotifierProvider((ref) => LoginViewModel(ref));

class LoginViewModel extends ChangeNotifier {
  final Ref ref;
  late AuthState state;

  final idTextController = TextEditingController(text: '');
  final passwordTextController = TextEditingController(text: '');

  LoginViewModel(this.ref) {
    state = ref.read(authServiceProvider);
    ref.listen<AuthState>(authServiceProvider, (previous, next) {
      if (previous != next) {
        state = next;
        print(state.toString());
        notifyListeners();
      }
    });
  }

  Future login() async {
    await ref.read(authServiceProvider.notifier).login(
          id: idTextController.text,
          password: passwordTextController.text,
        );
  }

  Future logout() async {
    await ref.read(authServiceProvider.notifier).logout();
  }
}
