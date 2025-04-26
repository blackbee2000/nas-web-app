import 'package:nasmobile/core/utils/log_util.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherUtil {
  LauncherUtil._();

  /// Open in browser
  static Future<void> launchInBrowser(String url) async {
    try {
      if (!await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      )) {
        LogUtil.logDebug('Could not launch $url');
      }
    } catch (e) {
      LogUtil.logDebug('Could not launch $url, error: $e');
    }
  }

  /// Make phone call
  static Future<void> launchCall(String phoneNumber) async {
    await launchUrl(Uri(scheme: 'tel', path: phoneNumber));
  }
}
