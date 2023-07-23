import 'package:flutter_front/user/model/datasource/login_datasource.dart';
import 'package:flutter_front/user/model/repository/auth_repository.dart';
import 'package:flutter_front/user/model/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider =
    StateNotifierProvider<AuthService, AuthState>((ref) {
  final authDataSource = ref.watch(authRepositoryProvider);
  return AuthService(authDataSource);
});

class AuthService extends StateNotifier<AuthState> {
  final AuthDataSource authDataSource;

  // TODO : add secure storage
  AuthService(this.authDataSource) : super(AuthStateNone());

  Future login({
    required String id,
    required String password,
  }) async {
    state = AuthStateLoading();
    await Future.delayed(const Duration(seconds: 3));
    try {
      final data = await authDataSource.login(id, password);
      state = AuthStateSuccess(data);
    } catch (e) {
      state = AuthStateError(e.toString());
    }
  }

  Future logout() async {
    await authDataSource.logout();
  }

  void _removeToken() {
    // TODO: implement removeToken
  }

  void _saveToken() {
    // TODO: implement saveToken
  }
}
