import 'package:flutter_front/common/utils/snack_bar_util.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static Future<void> launch(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      SnackBarUtil.showError("$uri에 연결할 수 없습니다.");
    }
  }
}
