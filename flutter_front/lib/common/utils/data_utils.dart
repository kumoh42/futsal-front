import 'package:flutter_dotenv/flutter_dotenv.dart';

class DataUtils {
  static pathToUrl(String value) => 'http://${dotenv.get('IP')}$value';

  static urlToPath(String value) => value.substring(7 + dotenv.env['IP']!.length);
}
