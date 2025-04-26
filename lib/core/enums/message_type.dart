import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/constants/app_url.dart';
import 'package:nasmobile/core/utils/launcher_util.dart';
import 'package:nasmobile/core/utils/replace_util.dart';

enum MessageType {
  sms(AppPaths.icSMS, 'SMS'),
  whatsapp(AppPaths.icWhatsapp, 'WhatsApp'),
  telegram(AppPaths.icTelegram, 'Telegram'),
  messager(AppPaths.icMessager, 'Messager'),
  zalo(AppPaths.icZalo, 'Zalo');

  const MessageType(
    this.icon,
    this.name,
  );
  final String icon;
  final String name;

  static Future<void> onTapType({
    required MessageType type,
    String? phoneNumber,
    String? userIdMessager,
    String? phoneZalo,
  }) async {
    /// SMS
    if (type == MessageType.sms) {
      await LauncherUtil.launchInBrowser(
        ReplaceUtil.replaceUrlApi(
          url: AppUrl.smsApp,
          objectReplace: {
            '{phoneNumber}': phoneNumber,
          },
        ),
      );
      return;
    }

    /// WhatsApp
    if (type == MessageType.whatsapp) {
      await LauncherUtil.launchInBrowser(
        ReplaceUtil.replaceUrlApi(
          url: AppUrl.whatsApp,
          objectReplace: {
            '{phoneNumber}': phoneNumber,
          },
        ),
      );
      return;
    }

    /// Telegram
    if (type == MessageType.telegram) {
      await LauncherUtil.launchInBrowser(
        ReplaceUtil.replaceUrlApi(
          url: AppUrl.telegramApp,
          objectReplace: {
            '{phoneNumber}': phoneNumber,
          },
        ),
      );
      return;
    }

    /// Messager
    if (type == MessageType.messager) {
      await LauncherUtil.launchInBrowser(
        ReplaceUtil.replaceUrlApi(
          url: AppUrl.messagerApp,
          objectReplace: {
            '{userId}': userIdMessager,
          },
        ),
      );
      return;
    }

    /// Zalo
    if (type == MessageType.zalo) {
      await LauncherUtil.launchInBrowser(
        ReplaceUtil.replaceUrlApi(
          url: AppUrl.zaloApp,
          objectReplace: {
            '{phoneNumber}': phoneNumber,
          },
        ),
      );
      return;
    }
  }
}
