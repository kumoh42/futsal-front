import 'package:dio/dio.dart';
import 'package:flutter_front/auth/model/dto/login_request_dto.dart';
import 'package:flutter_front/auth/model/entity/user_entity.dart';
import 'package:flutter_front/common/dio/dio.dart';
import 'package:flutter_front/auth/model/entity/login_response_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(dio);
});

class AuthRepository {
  final Dio dio;

  AuthRepository(this.dio);

  Future<LoginResponseEntity> login(LoginRequestDto loginRequestDto) async {
    final resp = await dio.post('/login');
    return LoginResponseEntity(
      accessToken: resp.headers.value('accessToken')!,
      refreshToken: resp.headers.value('refreshToken')!,
    );
  }

  Future logout() async {}

  Future<UserEntity> getUserInfo() async {
    return UserEntity();
  }
}
