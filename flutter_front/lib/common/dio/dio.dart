import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_front/auth/provider/auth_provider.dart';
import 'package:flutter_front/common/local_storage/local_storage.dart';
import 'package:flutter_front/common/utils/data_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider((ref) {
  final dio = Dio();
  final storage = ref.watch(localStorageProvider);
  dio.interceptors.add(CustomInterceptor(storage: storage, ref: ref));
  dio.options = options;
  return dio;
});

final options = BaseOptions(
  baseUrl: dotenv.get("IP"),
  headers: {'ngrok-skip-browser-warning' : true}
);

class CustomInterceptor extends Interceptor {
  final LocalStorage storage;
  final Ref ref;

  CustomInterceptor({required this.storage, required this.ref});

  // 1) 요청을 보낼때
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    print('[REQ] [${options.method}] ${options.uri}');

    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');
      final token = await storage.read(key: dotenv.get('ACCESS_TOKEN_KEY'));
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    if (options.headers['refreshToken'] == 'true') {
      options.headers.remove('accessToken');
      final token = await storage.read(key: dotenv.get('REFRESH_TOKEN_KEY'));
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    super.onRequest(options, handler);
  }

  // 2) 응답을 받을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    print(
        '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    if (response.requestOptions.path == '/auth') {
      _saveToken(response);
    }

    super.onResponse(response, handler);
  }

  // 3) 에러가 났을떄
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');

    final refreshToken =
        await storage.read(key: dotenv.get('REFRESH_TOKEN_KEY'));

    if (refreshToken == null) return handler.reject(err);

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();

      try {
        final resp = await dio.post(
          DataUtils.pathToUrl('/auth/token'),
          options: Options(headers: {
            'authorization': 'Bearer $refreshToken',
          }),
        );

        _saveToken(resp);

        final token = await storage.read(key: dotenv.get('ACCESS_TOKEN_KEY'));
        final options = err.requestOptions;
        options.headers.addAll({
          'authorization': 'Bearer $token',
        });

        final response = await dio.fetch(options);
        handler.resolve(response);
      } on DioException catch (e) {
        ref.read(authProvider.notifier).logout();
        return handler.reject(e);
      }
    }
    super.onError(err, handler);
  }

  Future _saveToken(Response response) async {
    final newAccessToken =
        response.headers.value(dotenv.get('ACCESS_TOKEN_KEY'));
    final newRefreshToken =
        response.headers.value(dotenv.get('REFRESH_TOKEN_KEY'));

    print("$newAccessToken, $newRefreshToken");

    try {
      Future.wait([
        storage.write(
          key: dotenv.get('ACCESS_TOKEN_KEY'),
          value: newAccessToken!.replaceFirst("Bearer ", ""),
        ),
        storage.write(
          key: dotenv.get('REFRESH_TOKEN_KEY'),
          value: newRefreshToken!.replaceFirst("Bearer ", ""),
        ),
      ]);
    } catch (e) {
      rethrow;
    }
  }
}
