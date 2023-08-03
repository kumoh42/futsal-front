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
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');
    super.onResponse(response, handler);
  }

  // 3) 에러가 났을떄
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri} ${err.message}');

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

        final newAccessToken = resp.data['accessToken'];
        final newRefreshToken = resp.data['accessToken'];

        await storage.write(
          key: dotenv.get('ACCESS_TOKEN_KEY'),
          value: newAccessToken,
        );

        await storage.write(
          key: dotenv.get('REFRESH_TOKEN_KEY'),
          value: newRefreshToken,
        );

        final options = err.requestOptions;
        options.headers.addAll({
          'authorization': 'Bearer $newAccessToken',
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
}
