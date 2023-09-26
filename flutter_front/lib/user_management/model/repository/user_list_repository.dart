import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_front/common/dio/dio.dart';
import 'package:flutter_front/user_management/model/entity/user_info_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'user_list_repository.g.dart';

final userListRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return UserListRepository(dio, baseUrl: '/members');
});

@RestApi()
abstract class UserListRepository {
  factory UserListRepository(Dio dio, {String baseUrl}) = _UserListRepository;

  @GET('/')
  @Headers(({'accessToken': 'true'}))
  Future<List<UserInfo>> getUserList();

  @DELETE('/{id}')
  @Headers(({'accessToken': 'true'}))
  Future removeUser(@Path('id') String id);
}
