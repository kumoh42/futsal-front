import 'package:dio/dio.dart';
import 'package:flutter_front/common/dio/dio.dart';
import 'package:flutter_front/user/model/entity/login_response_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../datasource/login_datasource.dart';

final authRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(dio);
});

class AuthRepository implements AuthDataSource {
  final Dio dio;

  AuthRepository(this.dio);

  @override
  Future<LoginResponseEntity> login(String id, String password) async {
    print("$id, $password");
    return LoginResponseEntity(
      accessToken: 'accessToken',
      refreshToken: 'refreshToken',
    );
  }

  @override
  Future logout() async {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
