import 'package:flutter_front/auth/model/entity/login_response_entity.dart';
import 'package:flutter_front/auth/model/repository/auth_repository.dart';
import 'package:flutter_front/auth/model/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider =
    StateNotifierProvider<AuthService, AuthState>((ref) {
  final authDataSource = ref.watch(authRepositoryProvider);
  return AuthService(authDataSource);
});

class AuthService extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  // TODO : add secure storage
  AuthService(this.authRepository) : super(AuthStateLoading()) {
    _getUserInfo();
  }

  Future login({
    required String id,
    required String password,
  }) async {
    state = AuthStateLoading();
    await Future.delayed(const Duration(seconds: 3));
    try {
      final resp = await authRepository.login(id, password);
      await _saveToken(resp);
      await _getUserInfo();
    } catch (e) {
      state = AuthStateError(e.toString());
    }
  }

  Future logout() async {
    state = AuthStateLoading();
    await authRepository.logout();
    await _removeToken();
    state = AuthStateNone();
  }

  Future _getUserInfo() async {
    // TODO: check token is null. if token is null set state None
    await Future.delayed(const Duration(seconds: 3));
    try {
      final data = await authRepository.getUserInfo();
      state = AuthStateSuccess(data);
    } catch (e) {
      state = AuthStateError(e.toString());
    }
  }

  Future _removeToken() async {
    // TODO: remove token from secure storage
  }

  Future _saveToken(LoginResponseEntity entity) async {
    // TODO: save token to secure storage
  }
}
