part of '../validator.dart';

/// Ensures the value contains a minimum of one uppercase character.
class HasUppercaseValidator extends TextValidator {
  const HasUppercaseValidator({
    required String error,
    bool ignoreEmptyValues = true,
  }) : super(error: error, ignoreEmptyValues: ignoreEmptyValues);

  /// Regex pattern to validate uppercase characters.
  static const _pattern = '[A-Z]';

  @override
  bool isValid(String? value) => hasMatch(
        _pattern,
        value!,
      );
}

/// Ensures the value contains a minimum of one lowercase character.
class HasLowercaseValidator extends TextValidator {
  const HasLowercaseValidator({
    required String error,
    bool ignoreEmptyValues = true,
  }) : super(error: error, ignoreEmptyValues: ignoreEmptyValues);

  /// Regex pattern to validate lowercase characters
  static const _pattern = '[a-z]';

  @override
  bool isValid(String? value) => hasMatch(
        _pattern,
        value!,
      );
}

/// Ensures the value contains a minimum of one numeric character.
class HasANumberValidator extends TextValidator {
  const HasANumberValidator({
    required String error,
    bool ignoreEmptyValues = true,
  }) : super(error: error, ignoreEmptyValues: ignoreEmptyValues);

  /// Regex pattern to validate lowercase characters.
  static const _pattern = '[0-9]';

  @override
  bool isValid(String? value) => hasMatch(
        _pattern,
        value!,
      );
}

/// Ensures the value length is contained in the range [min, max].
class LengthRangeValidator extends TextValidator {
  const LengthRangeValidator({
    required this.min,
    required this.max,
    required String error,
    bool ignoreEmptyValues = true,
  }) : super(error: error, ignoreEmptyValues: ignoreEmptyValues);

  final int min;
  final int max;

  @override
  bool isValid(String? value) => value!.length >= min && value.length <= max;
}

/// Ensures the num value is contained in the range [min, max].
class NumRangeValidator extends TextValidator {
  const NumRangeValidator({
    required this.min,
    required this.max,
    required String error,
    bool ignoreEmptyValues = true,
  }) : super(error: error, ignoreEmptyValues: ignoreEmptyValues);

  final num min;
  final num max;

  @override
  bool isValid(String? value) {
    final numericValue = num.tryParse(value!);
    if (numericValue == null) {
      return false;
    }

    return numericValue >= min && numericValue <= max;
  }
}

/// Ensures the value is a validly formatted email address.
class EmailValidator extends TextValidator {
  const EmailValidator({
    required String error,
    bool ignoreEmptyValues = true,
  }) : super(error: error, ignoreEmptyValues: ignoreEmptyValues);

  /// Regex pattern to validate email string.
  static const _emailPattern =
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$";

  @override
  bool isValid(String? value) => hasMatch(
        _emailPattern,
        value!,
        caseSensitive: false,
      );
}

/// Ensures the value is a validly formatted URL.
class UrlValidator extends TextValidator {
  const UrlValidator({
    required String error,
    bool ignoreEmptyValues = true,
  }) : super(error: error, ignoreEmptyValues: ignoreEmptyValues);

  /// Regex pattern to validate url string.
  static const _regex =
      r'(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})';

  @override
  bool isValid(String? value) => hasMatch(
        _regex,
        value!,
        caseSensitive: false,
      );
}

/// Ensures a custom regular expression string.
class PatternValidator extends TextValidator {
  PatternValidator({
    required this.pattern,
    required String error,
    this.caseSensitive = true,
    bool ignoreEmptyValues = true,
  }) : super(error: error, ignoreEmptyValues: ignoreEmptyValues);

  final Pattern pattern;
  final bool caseSensitive;

  @override
  bool isValid(String? value) => hasMatch(
        pattern.toString(),
        value!,
        caseSensitive: caseSensitive,
      );
}
