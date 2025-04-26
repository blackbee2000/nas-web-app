import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/enums/language_mode.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/themes/app_theme.dart';
import 'package:nasmobile/core/widgets/rounded_button_widget.dart';
import 'package:nasmobile/generated/l10n.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

enum DateTimeSelectMode {
  single(DateRangePickerSelectionMode.single),
  range(DateRangePickerSelectionMode.range);

  const DateTimeSelectMode(this.mode);
  final DateRangePickerSelectionMode mode;
}

class DateSelectWidget extends StatelessWidget {
  final DateRangePickerController _controller = DateRangePickerController();
  final DateTime startDate;

  /// End date cannot be null in [Range mode]
  final DateTime? endDate;
  final Function(DateRangePickerSelectionChangedArgs)? onSelectionChanged;
  final DateRangePickerView view;
  final DateTimeSelectMode dateTimeSelectMode;

  /// Callback selected value when press submit button
  ///
  /// Selected date on [Single mode]
  ///
  /// Or
  ///
  /// Selected date range on [Range mode]
  final void Function(DateTime?, PickerDateRange?)? onSubmit;
  final bool hasButtonSubmit;
  final DateTime? minDate;
  final DateTime? maxDate;

  DateSelectWidget({
    super.key,
    required this.startDate,
    this.endDate,
    this.onSelectionChanged,
    this.view = DateRangePickerView.month,
    this.dateTimeSelectMode = DateTimeSelectMode.single,
    this.onSubmit,
    this.hasButtonSubmit = true,
    this.minDate,
    this.maxDate,
  })  : assert(
          dateTimeSelectMode == DateTimeSelectMode.single || endDate != null,
          'End date cannot be null in Range mode',
        ),
        assert(
          view == DateRangePickerView.year &&
                  dateTimeSelectMode == DateTimeSelectMode.single ||
              view == DateRangePickerView.month &&
                  dateTimeSelectMode == DateTimeSelectMode.single ||
              view == DateRangePickerView.month &&
                  dateTimeSelectMode == DateTimeSelectMode.range,
          'Use view in year with DateTimeSelectMode.single or month with DateTimeSelectMode.single and DateTimeSelectMode.range only',
        );

  @override
  Widget build(BuildContext context) {
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
                child: SfDateRangePicker(
                  backgroundColor: Colors.white,
                  controller: _controller,
                  allowViewNavigation:
                      view == DateRangePickerView.year ? false : true,
                  minDate: minDate,
                  maxDate: maxDate,
                  view: view,
                  initialSelectedDate: startDate,
                  initialSelectedRange:
                      dateTimeSelectMode == DateTimeSelectMode.range
                          ? PickerDateRange(startDate, endDate)
                          : null,
                  showNavigationArrow: true,
                  selectionMode: dateTimeSelectMode.mode,
                  onSelectionChanged: onSelectionChanged,
                  headerHeight: 50,
                  headerStyle: const DateRangePickerHeaderStyle(
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      color: AppColors.blackText,
                      fontSize: AppDimension.largeSpace,
                      fontWeight: FontWeight.w700,
                    ),
                    backgroundColor: Colors.white,
                  ),
                  yearCellStyle: const DateRangePickerYearCellStyle(
                    textStyle: TextStyle(
                      color: AppColors.blackText,
                      fontSize: AppDimension.mediumSpace,
                      fontWeight: FontWeight.w500,
                    ),
                    todayTextStyle: TextStyle(
                      color: AppColors.blackText,
                      fontSize: AppDimension.mediumSpace,
                      fontWeight: FontWeight.w500,
                    ),
                    disabledDatesTextStyle: TextStyle(
                      color: AppColors.greyText,
                      fontSize: AppDimension.mediumSpace,
                      fontWeight: FontWeight.w500,
                    ),
                    leadingDatesTextStyle: TextStyle(
                      color: AppColors.greyText,
                      fontSize: AppDimension.mediumSpace,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  monthCellStyle: const DateRangePickerMonthCellStyle(
                    textStyle: TextStyle(
                      color: AppColors.blackText,
                      fontSize: AppDimension.mediumSpace,
                      fontWeight: FontWeight.w400,
                    ),
                    todayTextStyle: TextStyle(
                      color: AppColors.blackText,
                      fontSize: AppDimension.mediumSpace,
                      fontWeight: FontWeight.w400,
                    ),
                    weekendTextStyle: TextStyle(
                      color: AppColors.greyText,
                      fontSize: AppDimension.mediumSpace,
                      fontWeight: FontWeight.w400,
                    ),
                    disabledDatesTextStyle: TextStyle(
                      color: AppColors.greyText,
                      fontSize: AppDimension.mediumSpace,
                      fontWeight: FontWeight.w400,
                    ),
                    leadingDatesTextStyle: TextStyle(
                      color: AppColors.greyText,
                      fontSize: AppDimension.mediumSpace,
                      fontWeight: FontWeight.w400,
                    ),
                    trailingDatesTextStyle: TextStyle(
                      color: AppColors.greyText,
                      fontSize: AppDimension.mediumSpace,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  monthViewSettings: const DateRangePickerMonthViewSettings(
                    firstDayOfWeek: DateTime.monday,
                    weekendDays: [DateTime.sunday],
                    showTrailingAndLeadingDates: true,
                    viewHeaderStyle: DateRangePickerViewHeaderStyle(
                      textStyle: TextStyle(
                        color: AppColors.blackText,
                        fontSize: AppDimension.mediumSpace,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  todayHighlightColor: AppColors.pink400,
                  selectionColor: AppColors.pink600,
                  rangeSelectionColor: const Color(0xff7DB885),
                  rangeTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  selectionTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  endRangeSelectionColor: AppColors.pink600,
                  startRangeSelectionColor: AppColors.pink600,
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
                    onPressed: () {
                      if (dateTimeSelectMode == DateTimeSelectMode.single) {
                        onSubmit?.call(_controller.selectedDate, null);
                        return;
                      }

                      if (dateTimeSelectMode == DateTimeSelectMode.range) {
                        final range = _controller.selectedRange;
                        if (range?.startDate == null ||
                            range?.endDate == null) {
                          return;
                        }
                        onSubmit?.call(null, _controller.selectedRange);
                        return;
                      }
                    },
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
