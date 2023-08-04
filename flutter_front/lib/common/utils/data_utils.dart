import 'package:flutter_dotenv/flutter_dotenv.dart';

class DataUtils {
  static pathToUrl(String value) => '${dotenv.get('IP')}$value';

  static urlToPath(String value) =>
      value.substring(7 + dotenv.env['IP']!.length);

  static intToTimeRange(int value, int range) =>
      "${value.toString().padLeft(2, '0')}:00 ~ ${(value + range).toString().padLeft(2, '0')}:00";
}
