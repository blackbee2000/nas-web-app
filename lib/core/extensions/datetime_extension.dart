import 'dart:ui';

import 'package:nasmobile/core/enums/language_mode.dart';
import 'package:nasmobile/generated/l10n.dart';

extension DateTimeExtension on DateTime {
  String getWeekDay() {
    switch (weekday) {
      case 1:
        return S.current.monday;
      case 2:
        return S.current.tuesday;
      case 3:
        return S.current.wednesday;
      case 4:
        return S.current.thursday;
      case 5:
        return S.current.friday;
      case 6:
        return S.current.saturday;
      case 7:
        return S.current.sunday;
      default:
        return 'Err';
    }
  }

  String getMonth() {
    switch (month) {
      case 1:
        return S.current.january;
      case 2:
        return S.current.february;
      case 3:
        return S.current.march;
      case 4:
        return S.current.april;
      case 5:
        return S.current.may;
      case 6:
        return S.current.june;
      case 7:
        return S.current.july;
      case 8:
        return S.current.august;
      case 9:
        return S.current.september;
      case 10:
        return S.current.october;
      case 11:
        return S.current.november;
      case 12:
        return S.current.december;
      default:
        return 'Err';
    }
  }

  String getFullDateFormatString(Locale locale) {
    if (locale.languageCode == LanguageMode.vietnamese.locale.languageCode) {
      return '${getWeekDay()}, '
          '${S.current.day.toLowerCase()} ${day.toString().padLeft(2, '0')} '
          '${getMonth().toLowerCase()} '
          '${S.current.year.toLowerCase()} $year';
    }

    return '${getWeekDay()}, '
        '$day '
        '${getMonth()} '
        '$year';
  }

  DateTime typeDate() {
    return DateTime(year, month, day);
  }
}
