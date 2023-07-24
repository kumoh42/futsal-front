import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_front/auth/model/entity/login_response_entity.dart';
import 'package:flutter_front/auth/model/repository/auth_repository.dart';
import 'package:flutter_front/auth/model/state/auth_state.dart';
import 'package:flutter_front/common/local_storage/local_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_html/html.dart';

final authServiceProvider =
    StateNotifierProvider<AuthService, AuthState>((ref) {
  final authDataSource = ref.watch(authRepositoryProvider);
  final storage = ref.watch(localStorageProvider);
  return AuthService(authDataSource, storage);
});

class AuthService extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final Storage storage;

  AuthService(this.authRepository, this.storage) : super(AuthStateLoading()) {
    _getUserInfo();
  }

  Future login({
    required String id,
    required String password,
  }) async {
    state = AuthStateLoading();

    // TODO : remove delay for test
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
    final accessToken = storage[dotenv.get('ACCESS_TOKEN_KEY')];
    final refreshToken = storage[dotenv.get('REFRESH_TOKEN_KEY')];

    if(accessToken == null || refreshToken == null) {
      state = AuthStateNone();
      return;
    }

    // TODO : remove delay for test
    await Future.delayed(const Duration(seconds: 3));

    try {
      final data = await authRepository.getUserInfo();
      state = AuthStateSuccess(data);
    } catch (e) {
      state = AuthStateError(e.toString());
    }
  }

  Future _removeToken() async {
    storage.remove(dotenv.get('ACCESS_TOKEN_KEY'));
    storage.remove(dotenv.get('REFRESH_TOKEN_KEY'));
  }

  Future _saveToken(LoginResponseEntity entity) async {
    storage[dotenv.get('ACCESS_TOKEN_KEY')] = entity.accessToken;
    storage[dotenv.get('REFRESH_TOKEN_KEY')] = entity.refreshToken;
  }
}
