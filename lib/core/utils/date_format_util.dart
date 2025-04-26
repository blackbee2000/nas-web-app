import 'package:intl/intl.dart';

class DateFormatUtil {
  DateFormatUtil._();

  static const String kAppFormatPattern = 'yyyy-MM-dd HH:mm:ss';
  static const String kDDMMYYYY = 'dd/MM/yyyy';
  static const String kHHmm = 'HH:mm';
  static const String kDDMMYYYYHHmm = 'dd/MM/yyyy HH:mm';
  static const String kMMYYYY = 'MM/yyyy';

  static DateTime parseToDate(String input, [bool utc = false]) {
    return DateFormat(kAppFormatPattern).parse(input, utc).toLocal();
  }

  static String parseToString(DateTime input) {
    return DateFormat(kDDMMYYYY).format(input);
  }

  /// Will return first day in a month
  static DateTime getFirstDayInMonth(DateTime input) {
    return input.copyWith(day: 1);
  }

  /// Will return last day in a month
  static DateTime getLastDayInMonth(DateTime input) {
    return input.copyWith(
      month: input.month + 1,
      day: 0,
    );
  }

  /// Will return first day in previous month
  static DateTime getFirstDayInPreviousMonth(DateTime input) {
    return input.copyWith(
      month: input.month - 1,
      day: 1,
    );
  }

  /// Will return last day in next month
  static DateTime getLastDayInNextMonth(DateTime input) {
    return input.copyWith(
      month: input.month + 2,
      day: 0,
    );
  }

  /// Compare target day is the same day to now
  static bool isSameDayToNow(DateTime? input) =>
      isSameDay(input, DateTime.now());

  /// Compare two dates are same month
  static bool areSameMonth(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }

    if (a.year != b.year) {
      return false;
    }

    if (a.month != b.month) {
      return false;
    }

    return true;
  }

  /// Compare target day is before to now
  static bool isBeforeToNow(DateTime? input) {
    if (input == null) {
      return true;
    }

    final now = DateTime.now();
    int days = DateTime(input.year, input.month, input.day)
        .difference(DateTime(
          now.year,
          now.month,
          now.day,
        ))
        .inDays;

    if (days < 0) {
      return true;
    }

    return false;
  }

  /// Returns `date` in UTC format, without its time part.
  static DateTime normalizeDate(DateTime date) {
    return DateTime.utc(date.year, date.month, date.day);
  }

  /// Checks if two DateTime objects are the same day.
  /// Returns `false` if either of them is null.
  static bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }

    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
