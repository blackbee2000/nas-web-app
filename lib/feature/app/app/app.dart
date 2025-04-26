import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/enums/language_mode.dart';
import 'package:nasmobile/core/route/app_pages.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/core/themes/app_theme.dart';
import 'package:nasmobile/feature/app/app/app_binding.dart';
import 'package:nasmobile/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    // unawaited(ClientDatabaseManager.instance.closeConnection());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        final defaultLocale = LanguageMode.vietnamese.locale;
        if (locale == null) {
          S.load(defaultLocale);
          return defaultLocale;
        }

        if (locale.languageCode == LanguageMode.english.locale.languageCode) {
          S.load(locale);
          return locale;
        }

        S.load(defaultLocale);
        return defaultLocale;
      },
      theme: AppTheme.themeData,
      getPages: AppPages.pages,
      initialRoute: AppRoutes.splashScreen,
      initialBinding: AppBinding(),
      builder: EasyLoading.init(
        builder: (context, child) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: child,
            ),
          );
        },
      ),
    );
  }
}
