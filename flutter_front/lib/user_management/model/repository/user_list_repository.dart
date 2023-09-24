import 'package:dio/dio.dart';
import 'package:flutter_front/common/dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'user_list_repository.g.dart';

final userListRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return UserListRepository(dio);
});

@RestApi()
abstract class UserListRepository {
  factory UserListRepository(Dio dio, {String baseUrl}) = _UserListRepository;
}
