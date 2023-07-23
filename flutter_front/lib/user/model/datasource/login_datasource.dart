import 'package:flutter_front/user/model/entity/login_response_entity.dart';

abstract class AuthDataSource {
  Future<LoginResponseEntity> login(String id, String password);
  Future logout();
}