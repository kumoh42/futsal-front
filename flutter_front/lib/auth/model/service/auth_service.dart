import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_front/auth/model/entity/login_response_entity.dart';
import 'package:flutter_front/auth/model/repository/auth_repository.dart';
import 'package:flutter_front/auth/model/state/auth_state.dart';
import 'package:flutter_front/common/local_storage/local_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider =
    StateNotifierProvider<AuthService, AuthState>((ref) {
  final authDataSource = ref.watch(authRepositoryProvider);
  final storage = ref.watch(localStorageProvider);
  return AuthService(authDataSource, storage);
});

class AuthService extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final LocalStorage storage;

  AuthService(this.authRepository, this.storage) : super(AuthStateLoading()) {
    _getUserInfo();
  }

  Future login({
    required String id,
    required String password,
  }) async {
    state = AuthStateLoading();

    // TODO : remove delay for test
//    await Future.delayed(const Duration(seconds: 3));

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
    final accessToken = await storage.read(key: dotenv.get('ACCESS_TOKEN_KEY'));
    final refreshToken =
        await storage.read(key: dotenv.get('REFRESH_TOKEN_KEY'));

    if (accessToken == null || refreshToken == null) {
      state = AuthStateNone();
      return;
    }

    // TODO : remove delay for test
//    await Future.delayed(const Duration(seconds: 3));

    try {
      final data = await authRepository.getUserInfo();
      state = AuthStateSuccess(data);
    } catch (e) {
      state = AuthStateError(e.toString());
    }
  }

  Future _removeToken() async {
    Future.wait([
      storage.delete(key: dotenv.get('ACCESS_TOKEN_KEY')),
      storage.delete(key: dotenv.get('REFRESH_TOKEN_KEY')),
    ]);
  }

  Future _saveToken(LoginResponseEntity entity) async {
    Future.wait([
      storage.write(
        key: dotenv.get('ACCESS_TOKEN_KEY'),
        value: entity.accessToken,
      ),
      storage.write(
        key: dotenv.get('REFRESH_TOKEN_KEY'),
        value: entity.refreshToken,
      ),
    ]);
  }
}
