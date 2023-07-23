import 'package:flutter_front/common/const/data.dart';

class DataUtils {
  static pathToUrl(String value) => 'http://$ip$value';

  static urlToPath(String value) => value.substring(7 + ip.length);
}
