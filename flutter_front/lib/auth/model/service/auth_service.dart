import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_front/auth/model/dto/login_request_dto.dart';
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

  Future login({required String id, required String password}) async {
    state = AuthStateLoading();
    try {
      await authRepository.login(LoginRequestDto(id: id, password: password));
      await _getUserInfo();
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 400) {
        state = AuthStateError("id 또는 password가 틀렸습니다.");
        return;
      }
      state = AuthStateError("서버와 연결할 수 없습니다.");
    } catch (e) {
      state = AuthStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future logout() async {
    state = AuthStateLoading();
    await _removeToken();
    state = AuthStateNone();
  }

  Future _getUserInfo() async {
    final accessToken = await storage.read(key: dotenv.get('ACCESS_TOKEN_KEY'));
    final refreshToken = await storage.read(
      key: dotenv.get('REFRESH_TOKEN_KEY'),
    );

    if (accessToken == null || refreshToken == null) {
      state = AuthStateNone();
      return;
    }

    try {
      final data = await authRepository.getUserInfo();
      state = AuthStateSuccess(data);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 400) {
        state = AuthStateError(e.response!.data["message"]?.toString() ?? "알 수 없는 에러가 발생했습니다.");
      }
      state = AuthStateError("사용자 정보를 가져올 수 없습니다.");
    } catch (e) {
      state = AuthStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future _removeToken() async {
    Future.wait([
      storage.delete(key: dotenv.get('ACCESS_TOKEN_KEY')),
      storage.delete(key: dotenv.get('REFRESH_TOKEN_KEY')),
    ]);
  }
}
