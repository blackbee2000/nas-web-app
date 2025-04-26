import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/enums/language_mode.dart';
import 'package:nasmobile/core/themes/app_theme.dart';
import 'package:nasmobile/core/widgets/rounded_button_widget.dart';
import 'package:nasmobile/generated/l10n.dart';

class TimeSelectWidget extends StatelessWidget {
  final bool hasButtonSubmit;
  final CupertinoTimerPickerMode mode;
  final Duration duration;
  final Function(Duration duration) onSubmit;
  const TimeSelectWidget({
    super.key,
    this.hasButtonSubmit = true,
    this.mode = CupertinoTimerPickerMode.hm,
    required this.duration,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    Duration durationResult = duration;

    return IntrinsicHeight(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 350,
            child: MaterialApp(
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

                if (locale.languageCode ==
                    LanguageMode.english.locale.languageCode) {
                  S.load(locale);
                  return locale;
                }

                S.load(defaultLocale);
                return defaultLocale;
              },
              theme: AppTheme.themeData,
              home: Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimension.mediumSpace,
                  horizontal: AppDimension.smallSpace,
                ),
                child: CupertinoTimerPicker(
                  mode: mode,
                  initialTimerDuration: duration,
                  onTimerDurationChanged: (Duration duration) {
                    durationResult = duration;
                  },
                ),
              ),
            ),
          ),
          hasButtonSubmit
              ? Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(
                    AppDimension.mediumSpace,
                    AppDimension.mediumSpace,
                    AppDimension.mediumSpace,
                    max(
                      AppDimension.mediumSpace,
                      MediaQuery.of(Get.context!).viewPadding.bottom,
                    ),
                  ),
                  child: RoundedButtonWidget(
                    onPressed: () => onSubmit.call(durationResult),
                    text: S.current.confirm,
                  ),
                )
              : const SizedBox(
                  height: AppDimension.largeSpace,
                ),
        ],
      ),
    );
  }
}
