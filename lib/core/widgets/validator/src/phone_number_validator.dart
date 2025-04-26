part of '../validator.dart';

class PhoneNumberValidator extends TextValidator {
  final RegExp _phoneRegex = RegExp(r'^0[1-9]\d{8}$');

  PhoneNumberValidator({
    required String errorText,
    bool ignoreEmptyValues = true,
  }) : super(error: errorText, ignoreEmptyValues: ignoreEmptyValues);

  @override
  bool isValid(String? value) {
    return _phoneRegex.hasMatch(value!);
  }
}

/// Ensures the value is a validly formatted phone number.
class PhoneValidator extends TextValidator {
  const PhoneValidator({
    required String error,
    bool ignoreEmptyValues = true,
  }) : super(error: error, ignoreEmptyValues: ignoreEmptyValues);

  /// Regex pattern to validate phone string.
  static const _regex =
      r'^([+]?[\s0-9]+)?(\d{3}|[(]?[0-9]+[)])?([-]?[\s]?[0-9])+$';

  @override
  bool isValid(String? value) => hasMatch(
        _regex,
        value!,
        caseSensitive: false,
      );
}
