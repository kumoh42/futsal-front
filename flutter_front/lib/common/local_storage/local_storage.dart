import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:universal_html/html.dart' hide Platform;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageProvider = Provider((ref) => LocalStorage());

class LocalStorage {
  final _storage = kIsWeb ? window.localStorage : const FlutterSecureStorage();

  Future<String?> read({required String key}) async {
    return _storage is FlutterSecureStorage
        ? await (_storage as FlutterSecureStorage).read(key: key)
        : (_storage as Storage)[key];
  }

  Future delete({required String key}) async {
    return _storage is FlutterSecureStorage
        ? await (_storage as FlutterSecureStorage).delete(key: key)
        : (_storage as Storage).remove(key);
  }

  Future write({required String key, required String value}) async {
    return _storage is FlutterSecureStorage
        ? await (_storage as FlutterSecureStorage).write(key: key, value: value)
        : (_storage as Storage)[key] = value;
  }

  Future deleteAll({required String key, required String value}) async {
    return _storage is FlutterSecureStorage
        ? await (_storage as FlutterSecureStorage).deleteAll()
        : (_storage as Storage).removeWhere((key, value) => false);
  }
}
