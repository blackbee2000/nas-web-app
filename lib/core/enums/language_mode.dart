import 'package:flutter/material.dart';
import 'package:nasmobile/core/constants/app_paths.dart';

enum LanguageMode {
  vietnamese(Locale('vi', 'VN'), 'VIE', AppPaths.icVi, 'Tiếng Việt'),
  english(Locale('en', 'US'), 'ENG', AppPaths.icEn, 'Tiếng Anh');

  const LanguageMode(
    this.locale,
    this.shortName,
    this.icon,
    this.fullname,
  );
  final Locale locale;
  final String shortName;
  final String icon;
  final String fullname;

  static LanguageMode mapping(String? shortName) {
    if (shortName == null) {
      return LanguageMode.vietnamese;
    }

    if (shortName == LanguageMode.english.shortName) {
      return LanguageMode.english;
    }

    return LanguageMode.vietnamese;
  }
}
